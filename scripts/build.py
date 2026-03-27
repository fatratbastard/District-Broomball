#!/usr/bin/env python3
"""
build.py — Read from the league database and generate Hugo content/data files,
           then invoke hugo to build the static site.

Usage:
    python3 scripts/build.py [--db PATH] [--hugo PATH] [--no-hugo]
"""
import argparse
import json
import os
import re
import shutil
import sqlite3
import subprocess
import sys
import textwrap
from datetime import datetime
from typing import Any

SCRIPT_DIR   = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR     = os.path.dirname(SCRIPT_DIR)
DEFAULT_DB   = os.path.join(ROOT_DIR, 'league.db')
CONTENT_DIR  = os.path.join(ROOT_DIR, 'content')
DATA_DIR     = os.path.join(ROOT_DIR, 'data')


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def slugify(text: str) -> str:
    """Convert text to a URL-safe slug."""
    text = text.lower().strip()
    text = re.sub(r'[^\w\s-]', '', text)
    text = re.sub(r'[\s_-]+', '-', text)
    return text.strip('-')


def write_json(path: str, data: Any) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    print(f"  Wrote {os.path.relpath(path, ROOT_DIR)}")


def write_markdown(path: str, front_matter: dict, body: str) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    fm_lines = ['---']
    for k, v in front_matter.items():
        if isinstance(v, str) and ('"' in v or "'" in v or ':' in v or '\n' in v):
            escaped = v.replace('\\', '\\\\').replace('"', '\\"')
            fm_lines.append(f'{k}: "{escaped}"')
        elif isinstance(v, bool):
            fm_lines.append(f'{k}: {"true" if v else "false"}')
        else:
            fm_lines.append(f'{k}: {v}')
    fm_lines.append('---')
    fm_lines.append('')
    content = '\n'.join(fm_lines) + body.strip() + '\n'
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"  Wrote {os.path.relpath(path, ROOT_DIR)}")


# ---------------------------------------------------------------------------
# News
# ---------------------------------------------------------------------------

def generate_news(cur: sqlite3.Cursor) -> None:
    print("Generating news articles...")
    news_dir = os.path.join(CONTENT_DIR, 'news')

    # Remove previously generated articles (keep _index.md)
    for fn in os.listdir(news_dir):
        if fn != '_index.md' and fn.endswith('.md'):
            os.remove(os.path.join(news_dir, fn))

    rows = cur.execute("""
        SELECT title, slug, published_date, summary, body, author
        FROM news
        WHERE published = 1
        ORDER BY published_date DESC
    """).fetchall()

    for title, slug, pub_date, summary, body, author in rows:
        fm = {
            'title': title,
            'date': pub_date,
        }
        if summary:
            fm['summary'] = summary
        if author:
            fm['author'] = author

        path = os.path.join(news_dir, f'{slug}.md')
        write_markdown(path, fm, f'\n{body}\n')


# ---------------------------------------------------------------------------
# Info pages
# ---------------------------------------------------------------------------

def generate_info_pages(cur: sqlite3.Cursor) -> None:
    print("Generating info pages...")
    info_dir = os.path.join(CONTENT_DIR, 'info')

    for fn in os.listdir(info_dir):
        if fn != '_index.md' and fn.endswith('.md'):
            os.remove(os.path.join(info_dir, fn))

    rows = cur.execute("""
        SELECT slug, title, summary, body, sort_order
        FROM pages
        WHERE section = 'info' AND published = 1
        ORDER BY sort_order
    """).fetchall()

    for slug, title, summary, body, weight in rows:
        fm = {'title': title, 'weight': weight}
        if summary:
            fm['summary'] = summary
        path = os.path.join(info_dir, f'{slug}.md')
        write_markdown(path, fm, f'\n{body}\n')


# ---------------------------------------------------------------------------
# Standings
# ---------------------------------------------------------------------------

def compute_standings(cur: sqlite3.Cursor, season_id: int) -> list[dict]:
    """Compute standings from completed games for a given season."""
    teams = {
        row[0]: {'id': row[0], 'name': row[1], 'short_name': row[2],
                 'wins': 0, 'losses': 0, 'ties': 0, 'points': 0,
                 'games_played': 0, 'goals_for': 0, 'goals_against': 0,
                 'goal_diff': 0}
        for row in cur.execute("SELECT id, name, short_name FROM teams WHERE active=1").fetchall()
    }

    games = cur.execute("""
        SELECT home_team_id, away_team_id, home_score, away_score
        FROM games
        WHERE season_id = ? AND status = 'completed'
          AND home_score IS NOT NULL AND away_score IS NOT NULL
    """, (season_id,)).fetchall()

    for home_id, away_id, hs, as_ in games:
        if home_id not in teams or away_id not in teams:
            continue
        h = teams[home_id]
        a = teams[away_id]
        h['games_played'] += 1
        a['games_played'] += 1
        h['goals_for']      += hs
        h['goals_against']  += as_
        a['goals_for']      += as_
        a['goals_against']  += hs
        if hs > as_:
            h['wins']   += 1; h['points'] += 2
            a['losses'] += 1
        elif as_ > hs:
            a['wins']   += 1; a['points'] += 2
            h['losses'] += 1
        else:
            h['ties'] += 1; h['points'] += 1
            a['ties'] += 1; a['points'] += 1

    for t in teams.values():
        t['goal_diff'] = t['goals_for'] - t['goals_against']

    return sorted(
        teams.values(),
        key=lambda t: (-t['points'], -t['wins'], -t['goal_diff'], -t['goals_for'])
    )


def generate_standings(cur: sqlite3.Cursor, season_id: int) -> None:
    print("Generating standings data...")
    teams = compute_standings(cur, season_id)
    write_json(os.path.join(DATA_DIR, 'standings.json'), {'teams': teams})


# ---------------------------------------------------------------------------
# Schedule
# ---------------------------------------------------------------------------

def generate_schedule(cur: sqlite3.Cursor, season_id: int) -> None:
    print("Generating schedule data...")
    team_names = {
        row[0]: (row[1], row[2])
        for row in cur.execute("SELECT id, name, short_name FROM teams").fetchall()
    }

    rows = cur.execute("""
        SELECT game_date, game_time, home_team_id, away_team_id,
               home_score, away_score, status, location, notes
        FROM games
        WHERE season_id = ?
        ORDER BY game_date, game_time
    """, (season_id,)).fetchall()

    games = []
    for date, time_, hid, aid, hs, as_, status, loc, notes in rows:
        try:
            date_fmt = datetime.strptime(date, '%Y-%m-%d').strftime('%b %d, %Y')
        except Exception:
            date_fmt = date
        games.append({
            'date':       date_fmt,
            'date_raw':   date,
            'time':       time_ or 'TBD',
            'home_team':  team_names.get(hid, ('Unknown', '?'))[0],
            'away_team':  team_names.get(aid, ('Unknown', '?'))[0],
            'home_score': hs,
            'away_score': as_,
            'status':     status,
            'location':   loc or '',
            'notes':      notes or '',
        })

    write_json(os.path.join(DATA_DIR, 'schedule.json'), {'games': games})


# ---------------------------------------------------------------------------
# Season stats
# ---------------------------------------------------------------------------

def generate_season_stats(cur: sqlite3.Cursor, season_id: int) -> None:
    print("Generating season stats data...")
    team_names = {
        row[0]: row[1]
        for row in cur.execute("SELECT id, short_name FROM teams").fetchall()
    }

    # Games played per player in this season
    gp_map = {}
    for pid, gp in cur.execute("""
        SELECT pgs.player_id, COUNT(DISTINCT pgs.game_id)
        FROM player_game_stats pgs
        JOIN games g ON g.id = pgs.game_id
        WHERE g.season_id = ?
        GROUP BY pgs.player_id
    """, (season_id,)).fetchall():
        gp_map[pid] = gp

    rows = cur.execute("""
        SELECT p.id, p.first_name, p.last_name, p.team_id,
               COALESCE(SUM(pgs.goals), 0)           AS goals,
               COALESCE(SUM(pgs.assists), 0)         AS assists,
               COALESCE(SUM(pgs.penalty_minutes), 0) AS pim
        FROM players p
        JOIN player_game_stats pgs ON pgs.player_id = p.id
        JOIN games g ON g.id = pgs.game_id
        WHERE g.season_id = ?
        GROUP BY p.id
        HAVING goals + assists > 0
    """, (season_id,)).fetchall()
    rows = sorted(rows, key=lambda r: (-(r[4] + r[5]), -r[4]))

    players = []
    for rank, (pid, fn, ln, tid, g, a, pim) in enumerate(rows, start=1):
        gp = gp_map.get(pid, 0)
        pts = g + a
        ppg = round(pts / gp, 2) if gp else 0.0
        players.append({
            'rank':           rank,
            'name':           f'{fn} {ln}',
            'team':           team_names.get(tid, ''),
            'games_played':   gp,
            'goals':          g,
            'assists':        a,
            'points':         pts,
            'points_per_game': f'{ppg:.2f}',
            'penalty_minutes': pim,
        })

    # Team totals
    team_rows = cur.execute("""
        SELECT p.team_id,
               COUNT(DISTINCT pgs.game_id)            AS gp,
               COALESCE(SUM(pgs.goals), 0)            AS goals,
               COALESCE(SUM(pgs.assists), 0)          AS assists,
               COALESCE(SUM(pgs.penalty_minutes), 0)  AS pim
        FROM player_game_stats pgs
        JOIN players p ON p.id = pgs.player_id
        JOIN games g ON g.id = pgs.game_id
        WHERE g.season_id = ?
        GROUP BY p.team_id
        ORDER BY goals DESC
    """, (season_id,)).fetchall()

    team_stats = [
        {
            'team':            team_names.get(tid, ''),
            'games_played':    gp,
            'goals':           g,
            'assists':         a,
            'points':          g + a,
            'penalty_minutes': pim,
        }
        for tid, gp, g, a, pim in team_rows
    ]

    write_json(os.path.join(DATA_DIR, 'season_stats.json'), {
        'players':    players,
        'team_stats': team_stats,
    })


# ---------------------------------------------------------------------------
# All-time stats
# ---------------------------------------------------------------------------

def generate_alltime_stats(cur: sqlite3.Cursor) -> None:
    print("Generating all-time stats data...")
    team_names = {
        row[0]: row[1]
        for row in cur.execute("SELECT id, short_name FROM teams").fetchall()
    }

    rows = cur.execute("""
        SELECT p.id, p.first_name, p.last_name,
               COUNT(DISTINCT g.season_id)            AS seasons,
               COUNT(DISTINCT pgs.game_id)            AS gp,
               COALESCE(SUM(pgs.goals), 0)            AS goals,
               COALESCE(SUM(pgs.assists), 0)          AS assists,
               COALESCE(SUM(pgs.penalty_minutes), 0)  AS pim
        FROM players p
        JOIN player_game_stats pgs ON pgs.player_id = p.id
        JOIN games g ON g.id = pgs.game_id
        GROUP BY p.id
        HAVING goals + assists > 0
    """).fetchall()
    rows = sorted(rows, key=lambda r: (-(r[5] + r[6]), -r[5]))

    players = []
    for rank, (pid, fn, ln, seasons, gp, g, a, pim) in enumerate(rows, start=1):
        players.append({
            'rank':            rank,
            'name':            f'{fn} {ln}',
            'seasons':         seasons,
            'games_played':    gp,
            'goals':           g,
            'assists':         a,
            'points':          g + a,
            'penalty_minutes': pim,
        })

    # Season records
    season_rows = cur.execute("""
        SELECT s.id, s.name,
               COUNT(DISTINCT g.id)   AS games_played,
               COUNT(DISTINCT ht.id)  AS teams
        FROM seasons s
        LEFT JOIN games g  ON g.season_id = s.id AND g.status = 'completed'
        LEFT JOIN teams ht ON ht.id IN (g.home_team_id, g.away_team_id)
        GROUP BY s.id
        ORDER BY s.id DESC
    """).fetchall()

    season_records = []
    for sid, sname, gp, teams in season_rows:
        # Top scorer this season
        scorer = cur.execute("""
            SELECT p.first_name, p.last_name,
                   COALESCE(SUM(pgs.goals + pgs.assists), 0) AS pts
            FROM player_game_stats pgs
            JOIN players p ON p.id = pgs.player_id
            JOIN games g   ON g.id = pgs.game_id
            WHERE g.season_id = ?
            GROUP BY p.id
            ORDER BY pts DESC
            LIMIT 1
        """, (sid,)).fetchone()

        # Champion = team with most points that season (simplified)
        standings = compute_standings(cur, sid)
        current_season_id = cur.execute(
            "SELECT id FROM seasons WHERE is_current = 1"
        ).fetchone()
        is_current = current_season_id and current_season_id[0] == sid

        season_records.append({
            'season':          sname,
            'champion':        None if is_current else (standings[0]['name'] if standings else ''),
            'teams':           5,
            'games_played':    gp,
            'top_scorer':      f"{scorer[0]} {scorer[1]}" if scorer else '',
            'top_scorer_pts':  scorer[2] if scorer else 0,
        })

    write_json(os.path.join(DATA_DIR, 'alltime_stats.json'), {
        'players':        players,
        'season_records': season_records,
    })


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def run_hugo(hugo_bin: str) -> None:
    print("Running hugo build...")
    result = subprocess.run(
        [hugo_bin, '--minify'],
        cwd=ROOT_DIR,
        capture_output=False
    )
    if result.returncode != 0:
        print("Hugo build failed.", file=sys.stderr)
        sys.exit(result.returncode)
    print("Hugo build complete. Output in public/")


def main() -> None:
    parser = argparse.ArgumentParser(description='Build the District Broomball League site')
    parser.add_argument('--db',      default=DEFAULT_DB, help='Path to SQLite database')
    parser.add_argument('--hugo',    default='hugo',     help='Path to hugo binary')
    parser.add_argument('--no-hugo', action='store_true', help='Skip running hugo after generating files')
    args = parser.parse_args()

    if not os.path.exists(args.db):
        print(f"Database not found: {args.db}", file=sys.stderr)
        print("Run  python3 scripts/init_db.py  first.", file=sys.stderr)
        sys.exit(1)

    conn = sqlite3.connect(args.db)
    conn.execute("PRAGMA foreign_keys = ON")
    cur = conn.cursor()

    # Determine current season
    row = cur.execute("SELECT id FROM seasons WHERE is_current = 1").fetchone()
    if not row:
        print("No current season found in database.", file=sys.stderr)
        sys.exit(1)
    season_id = row[0]
    print(f"Current season ID: {season_id}")

    generate_news(cur)
    generate_info_pages(cur)
    generate_standings(cur, season_id)
    generate_schedule(cur, season_id)
    generate_season_stats(cur, season_id)
    generate_alltime_stats(cur)

    conn.close()
    print("Content and data files generated.")

    if not args.no_hugo:
        # Try to find hugo binary
        hugo_bin = args.hugo
        if not shutil.which(hugo_bin):
            # Try common locations
            candidates = [
                os.path.expanduser('~/.local/bin/hugo'),
                '/usr/local/bin/hugo',
                '/usr/bin/hugo',
            ]
            for c in candidates:
                if os.path.exists(c):
                    hugo_bin = c
                    break
            else:
                print(f"Hugo binary not found. Generated files are ready — run 'hugo' manually.")
                return
        run_hugo(hugo_bin)


if __name__ == '__main__':
    main()
