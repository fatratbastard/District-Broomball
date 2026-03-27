-- District Broomball League Database Schema

CREATE TABLE IF NOT EXISTS teams (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,
    short_name  TEXT NOT NULL,
    color       TEXT DEFAULT '#1a4480',
    active      INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS players (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name     TEXT NOT NULL,
    last_name      TEXT NOT NULL,
    team_id        INTEGER REFERENCES teams(id),
    position       TEXT,          -- forward, defense, goalie
    jersey_number  INTEGER,
    active         INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS seasons (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,     -- e.g. "Winter 2025-2026"
    start_date  TEXT,
    end_date    TEXT,
    is_current  INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS games (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    season_id     INTEGER NOT NULL REFERENCES seasons(id),
    game_date     TEXT NOT NULL,   -- YYYY-MM-DD
    game_time     TEXT,            -- HH:MM
    home_team_id  INTEGER NOT NULL REFERENCES teams(id),
    away_team_id  INTEGER NOT NULL REFERENCES teams(id),
    home_score    INTEGER,
    away_score    INTEGER,
    status        TEXT DEFAULT 'scheduled',  -- scheduled | completed | postponed
    location      TEXT,
    notes         TEXT
);

CREATE TABLE IF NOT EXISTS player_game_stats (
    id               INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id          INTEGER NOT NULL REFERENCES games(id),
    player_id        INTEGER NOT NULL REFERENCES players(id),
    goals            INTEGER DEFAULT 0,
    assists          INTEGER DEFAULT 0,
    penalty_minutes  INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS news (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    title          TEXT NOT NULL,
    slug           TEXT UNIQUE NOT NULL,
    published_date TEXT NOT NULL,    -- YYYY-MM-DD
    summary        TEXT,
    body           TEXT NOT NULL,
    author         TEXT,
    published      INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS pages (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    section     TEXT NOT NULL,       -- 'info', etc.
    slug        TEXT UNIQUE NOT NULL,
    title       TEXT NOT NULL,
    summary     TEXT,
    body        TEXT NOT NULL,
    sort_order  INTEGER DEFAULT 0,
    published   INTEGER DEFAULT 1
);
