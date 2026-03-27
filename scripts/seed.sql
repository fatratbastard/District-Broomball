-- Seed data for District Broomball League

-- Teams
INSERT INTO teams (name, short_name, color) VALUES
  ('Polar Bears',   'POL', '#1a4480'),
  ('Ice Storm',     'ICE', '#0d5c63'),
  ('Frozen Few',    'FRZ', '#6f3e9e'),
  ('Cold Fronts',   'CFR', '#b84c0a'),
  ('Arctic Wolves', 'ARW', '#1a5c1a');

-- Seasons
INSERT INTO seasons (name, start_date, end_date, is_current) VALUES
  ('Winter 2023-2024', '2023-11-06', '2024-03-11', 0),
  ('Winter 2024-2025', '2024-11-04', '2025-03-10', 0),
  ('Winter 2025-2026', '2025-11-03', '2026-03-16', 1);

-- Players (team assignments for current season)
INSERT INTO players (first_name, last_name, team_id, position, jersey_number) VALUES
  -- Polar Bears (team 1)
  ('Marcus',  'Thibodeau',  1, 'forward',  11),
  ('Sarah',   'Kowalski',   1, 'forward',  17),
  ('Devon',   'Lafleur',    1, 'defense',   4),
  ('Riley',   'Nakamura',   1, 'goalie',   30),
  ('Jordan',  'Okonkwo',    1, 'forward',   9),
  -- Ice Storm (team 2)
  ('Priya',   'Mehta',      2, 'forward',  12),
  ('Tyler',   'Bergstrom',  2, 'forward',  22),
  ('Casey',   'Fontaine',   2, 'defense',   7),
  ('Avery',   'Szymanski',  2, 'goalie',   31),
  ('Quinn',   'Delacroix',  2, 'forward',  14),
  -- Frozen Few (team 3)
  ('Nadia',   'Volkov',     3, 'forward',  10),
  ('Sam',     'Oduya',      3, 'forward',  19),
  ('Parker',  'Hristov',    3, 'defense',   5),
  ('Morgan',  'Lindqvist',  3, 'goalie',   35),
  ('Alex',    'Bourassa',   3, 'forward',  21),
  -- Cold Fronts (team 4)
  ('Jamie',   'Tremblay',   4, 'forward',   8),
  ('Chris',   'Watanabe',   4, 'forward',  16),
  ('Taylor',  'Novak',      4, 'defense',   3),
  ('Bailey',  'Rios',       4, 'goalie',   33),
  ('Drew',    'Macdonald',  4, 'forward',  18),
  -- Arctic Wolves (team 5)
  ('Sasha',   'Petrov',     5, 'forward',  15),
  ('Robin',   'Chaudhary',  5, 'forward',  23),
  ('Logan',   'Beaumont',   5, 'defense',   6),
  ('Harper',  'Johansson',  5, 'goalie',   29),
  ('Reese',   'Castellano', 5, 'forward',  20);

-- Games — Season 3 (current, Winter 2025-2026)
-- Completed games
INSERT INTO games (season_id, game_date, game_time, home_team_id, away_team_id, home_score, away_score, status, location) VALUES
  (3, '2025-11-10', '20:00', 1, 2,  4, 2, 'completed', 'Rideau Rink'),
  (3, '2025-11-10', '21:30', 3, 4,  1, 3, 'completed', 'Rideau Rink'),
  (3, '2025-11-17', '20:00', 5, 1,  2, 5, 'completed', 'Rideau Rink'),
  (3, '2025-11-17', '21:30', 2, 3,  0, 2, 'completed', 'Rideau Rink'),
  (3, '2025-11-24', '20:00', 4, 5,  3, 1, 'completed', 'Rideau Rink'),
  (3, '2025-12-01', '20:00', 1, 3,  3, 3, 'completed', 'Rideau Rink'),
  (3, '2025-12-01', '21:30', 2, 4,  4, 1, 'completed', 'Rideau Rink'),
  (3, '2025-12-08', '20:00', 5, 3,  2, 4, 'completed', 'Rideau Rink'),
  (3, '2025-12-08', '21:30', 1, 4,  6, 2, 'completed', 'Rideau Rink'),
  (3, '2025-12-15', '20:00', 2, 5,  3, 3, 'completed', 'Rideau Rink'),
  (3, '2026-01-05', '20:00', 3, 1,  2, 4, 'completed', 'Rideau Rink'),
  (3, '2026-01-05', '21:30', 4, 2,  1, 5, 'completed', 'Rideau Rink'),
  (3, '2026-01-12', '20:00', 5, 4,  3, 2, 'completed', 'Rideau Rink'),
  (3, '2026-01-12', '21:30', 1, 5,  4, 1, 'completed', 'Rideau Rink'),
  (3, '2026-01-19', '20:00', 3, 2,  1, 2, 'completed', 'Rideau Rink'),
  (3, '2026-01-26', '20:00', 4, 1,  2, 5, 'completed', 'Rideau Rink'),
  (3, '2026-02-02', '20:00', 2, 1,  1, 3, 'completed', 'Rideau Rink'),
  (3, '2026-02-02', '21:30', 5, 3,  4, 2, 'completed', 'Rideau Rink'),
  (3, '2026-02-09', '20:00', 4, 3,  2, 3, 'completed', 'Rideau Rink'),
  (3, '2026-02-16', '20:00', 1, 2,  5, 2, 'completed', 'Rideau Rink'),
  -- Upcoming
  (3, '2026-03-02', '20:00', 3, 5, NULL, NULL, 'scheduled', 'Rideau Rink'),
  (3, '2026-03-02', '21:30', 4, 1, NULL, NULL, 'scheduled', 'Rideau Rink'),
  (3, '2026-03-09', '20:00', 2, 5, NULL, NULL, 'scheduled', 'Rideau Rink'),
  (3, '2026-03-09', '21:30', 3, 4, NULL, NULL, 'scheduled', 'Rideau Rink'),
  (3, '2026-03-16', '20:00', 1, 5, NULL, NULL, 'scheduled', 'Rideau Rink');

-- Games — Season 1 (Winter 2023-2024) — a few completed games for all-time stats
INSERT INTO games (season_id, game_date, game_time, home_team_id, away_team_id, home_score, away_score, status, location) VALUES
  (1, '2023-11-06', '20:00', 1, 2,  3, 2, 'completed', 'Rideau Rink'),
  (1, '2023-11-06', '21:30', 3, 4,  4, 1, 'completed', 'Rideau Rink'),
  (1, '2023-11-13', '20:00', 5, 1,  1, 2, 'completed', 'Rideau Rink'),
  (1, '2023-11-13', '21:30', 2, 3,  3, 3, 'completed', 'Rideau Rink'),
  (1, '2023-11-20', '20:00', 4, 5,  2, 4, 'completed', 'Rideau Rink'),
  (1, '2023-11-27', '20:00', 1, 4,  5, 1, 'completed', 'Rideau Rink'),
  (1, '2023-12-04', '20:00', 2, 5,  2, 2, 'completed', 'Rideau Rink'),
  (1, '2023-12-11', '20:00', 3, 5,  3, 4, 'completed', 'Rideau Rink'),
  (1, '2024-01-08', '20:00', 1, 3,  4, 2, 'completed', 'Rideau Rink'),
  (1, '2024-01-15', '20:00', 2, 4,  3, 1, 'completed', 'Rideau Rink'),
  (1, '2024-01-22', '20:00', 5, 2,  2, 3, 'completed', 'Rideau Rink'),
  (1, '2024-01-29', '20:00', 4, 3,  1, 2, 'completed', 'Rideau Rink'),
  (1, '2024-02-05', '20:00', 1, 5,  3, 1, 'completed', 'Rideau Rink'),
  (1, '2024-02-12', '20:00', 2, 1,  2, 4, 'completed', 'Rideau Rink'),
  (1, '2024-02-26', '20:00', 3, 2,  1, 3, 'completed', 'Rideau Rink'),
  (1, '2024-03-04', '20:00', 5, 4,  3, 2, 'completed', 'Rideau Rink'),
  (1, '2024-03-11', '20:00', 1, 3,  4, 3, 'completed', 'Rideau Rink');

-- Games — Season 2 (Winter 2024-2025)
INSERT INTO games (season_id, game_date, game_time, home_team_id, away_team_id, home_score, away_score, status, location) VALUES
  (2, '2024-11-04', '20:00', 2, 1,  2, 4, 'completed', 'Rideau Rink'),
  (2, '2024-11-04', '21:30', 4, 3,  3, 2, 'completed', 'Rideau Rink'),
  (2, '2024-11-11', '20:00', 1, 4,  4, 1, 'completed', 'Rideau Rink'),
  (2, '2024-11-18', '20:00', 3, 5,  2, 3, 'completed', 'Rideau Rink'),
  (2, '2024-11-25', '20:00', 5, 2,  1, 2, 'completed', 'Rideau Rink'),
  (2, '2024-12-02', '20:00', 1, 3,  3, 2, 'completed', 'Rideau Rink'),
  (2, '2024-12-09', '20:00', 2, 4,  5, 1, 'completed', 'Rideau Rink'),
  (2, '2024-12-16', '20:00', 5, 1,  2, 3, 'completed', 'Rideau Rink'),
  (2, '2025-01-06', '20:00', 3, 4,  4, 2, 'completed', 'Rideau Rink'),
  (2, '2025-01-13', '20:00', 4, 5,  1, 3, 'completed', 'Rideau Rink'),
  (2, '2025-01-20', '20:00', 2, 3,  2, 2, 'completed', 'Rideau Rink'),
  (2, '2025-01-27', '20:00', 1, 5,  4, 2, 'completed', 'Rideau Rink'),
  (2, '2025-02-03', '20:00', 3, 1,  1, 3, 'completed', 'Rideau Rink'),
  (2, '2025-02-10', '20:00', 5, 4,  2, 1, 'completed', 'Rideau Rink'),
  (2, '2025-02-17', '20:00', 4, 2,  2, 4, 'completed', 'Rideau Rink'),
  (2, '2025-02-24', '20:00', 1, 2,  5, 3, 'completed', 'Rideau Rink'),
  (2, '2025-03-03', '20:00', 3, 5,  3, 1, 'completed', 'Rideau Rink'),
  (2, '2025-03-10', '20:00', 2, 5,  4, 2, 'completed', 'Rideau Rink');

-- Player game stats — season 3 (current) completed games
-- game 1: POL 4 - ICE 2
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (1, 1, 2, 1, 0),  -- Thibodeau
  (1, 2, 1, 1, 0),  -- Kowalski
  (1, 5, 1, 0, 2),  -- Okonkwo
  (1, 6, 1, 0, 0),  -- Mehta
  (1, 7, 1, 0, 0);  -- Bergstrom
-- game 2: FRZ 1 - CFR 3
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (2, 11, 1, 0, 0), -- Volkov
  (2, 16, 2, 1, 0), -- Tremblay
  (2, 17, 1, 1, 2); -- Watanabe
-- game 3: ARW 2 - POL 5
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (3, 21, 1, 1, 0), -- Petrov
  (3, 22, 1, 0, 0), -- Chaudhary
  (3, 1,  3, 0, 0), -- Thibodeau
  (3, 2,  1, 2, 0), -- Kowalski
  (3, 5,  1, 1, 0); -- Okonkwo
-- game 4: ICE 0 - FRZ 2
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (4, 11, 1, 0, 0), -- Volkov
  (4, 12, 1, 1, 0); -- Oduya
-- game 5: CFR 3 - ARW 1
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (5, 16, 1, 1, 0), -- Tremblay
  (5, 17, 2, 0, 0), -- Watanabe
  (5, 21, 1, 0, 2); -- Petrov
-- game 6: POL 3 - FRZ 3
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (6, 1,  1, 1, 0), -- Thibodeau
  (6, 2,  1, 0, 0), -- Kowalski
  (6, 5,  1, 0, 2), -- Okonkwo
  (6, 11, 2, 0, 0), -- Volkov
  (6, 15, 1, 1, 0); -- Bourassa
-- game 7: ICE 4 - CFR 1
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (7, 6,  2, 1, 0), -- Mehta
  (7, 7,  1, 1, 0), -- Bergstrom
  (7, 10, 1, 2, 0), -- Delacroix
  (7, 16, 1, 0, 0); -- Tremblay
-- game 8: ARW 2 - FRZ 4
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (8, 21, 1, 0, 0), -- Petrov
  (8, 22, 1, 1, 0), -- Chaudhary
  (8, 11, 2, 1, 0), -- Volkov
  (8, 12, 2, 0, 2); -- Oduya
-- game 9: POL 6 - CFR 2
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (9, 1,  2, 1, 0), -- Thibodeau
  (9, 2,  2, 1, 0), -- Kowalski
  (9, 5,  1, 2, 0), -- Okonkwo
  (9, 3,  1, 1, 0), -- Lafleur (defense goal!)
  (9, 17, 1, 0, 2), -- Watanabe
  (9, 20, 1, 0, 0); -- Macdonald
-- game 10: ICE 3 - ARW 3
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (10, 6,  2, 0, 0), -- Mehta
  (10, 10, 1, 1, 0), -- Delacroix
  (10, 21, 2, 0, 0), -- Petrov
  (10, 25, 1, 1, 0); -- Castellano
-- game 11: FRZ 2 - POL 4
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (11, 11, 1, 0, 0), -- Volkov
  (11, 12, 1, 1, 0), -- Oduya
  (11, 1,  2, 1, 0), -- Thibodeau
  (11, 2,  1, 2, 0), -- Kowalski
  (11, 5,  1, 0, 0); -- Okonkwo
-- game 12: CFR 1 - ICE 5
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (12, 16, 1, 0, 0), -- Tremblay
  (12, 6,  2, 1, 0), -- Mehta
  (12, 7,  2, 1, 0), -- Bergstrom
  (12, 10, 1, 1, 0); -- Delacroix
-- game 13: ARW 3 - CFR 2
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (13, 21, 1, 1, 0), -- Petrov
  (13, 22, 1, 0, 0), -- Chaudhary
  (13, 25, 1, 1, 0), -- Castellano
  (13, 17, 1, 0, 2), -- Watanabe
  (13, 20, 1, 0, 0); -- Macdonald
-- game 14: POL 4 - ARW 1
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (14, 1,  2, 0, 0), -- Thibodeau
  (14, 2,  1, 1, 0), -- Kowalski
  (14, 5,  1, 2, 2), -- Okonkwo
  (14, 21, 1, 0, 0); -- Petrov
-- game 15: FRZ 1 - ICE 2
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (15, 11, 1, 0, 2), -- Volkov
  (15, 7,  1, 0, 0), -- Bergstrom
  (15, 10, 1, 1, 0); -- Delacroix
-- game 16: CFR 2 - POL 5
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (16, 17, 1, 0, 0), -- Watanabe
  (16, 20, 1, 1, 0), -- Macdonald
  (16, 1,  3, 0, 0), -- Thibodeau
  (16, 2,  1, 1, 0), -- Kowalski
  (16, 5,  1, 2, 0); -- Okonkwo
-- game 17: ICE 1 - POL 3
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (17, 6,  1, 0, 0), -- Mehta
  (17, 1,  1, 1, 0), -- Thibodeau
  (17, 2,  1, 0, 0), -- Kowalski
  (17, 5,  1, 1, 2); -- Okonkwo
-- game 18: ARW 4 - FRZ 2
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (18, 21, 2, 1, 0), -- Petrov
  (18, 22, 1, 1, 0), -- Chaudhary
  (18, 25, 1, 0, 0), -- Castellano
  (18, 11, 1, 0, 0), -- Volkov
  (18, 12, 1, 0, 2); -- Oduya
-- game 19: CFR 2 - FRZ 3
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (19, 16, 1, 0, 0), -- Tremblay
  (19, 17, 1, 1, 0), -- Watanabe
  (19, 11, 1, 1, 0), -- Volkov
  (19, 12, 1, 0, 0), -- Oduya
  (19, 15, 1, 1, 0); -- Bourassa
-- game 20: POL 5 - ICE 2
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes) VALUES
  (20, 1,  2, 1, 0), -- Thibodeau
  (20, 2,  2, 0, 0), -- Kowalski
  (20, 5,  1, 2, 0), -- Okonkwo
  (20, 6,  1, 0, 0), -- Mehta
  (20, 7,  1, 0, 2); -- Bergstrom

-- News articles
INSERT INTO news (title, slug, published_date, summary, body, author) VALUES
  (
    'Polar Bears Lead the Pack with Dominant Season',
    'polar-bears-lead-the-pack',
    '2026-02-18',
    'After twenty games, the Polar Bears sit atop the standings with an impressive record.',
    'The Polar Bears have had an outstanding Winter 2025-2026 season, currently leading the District Broomball League standings with a 14-4-2 record and 30 points. Star forward Marcus Thibodeau leads all scorers with a remarkable 25 goals and 18 assists for 43 points through 20 games.

"The team chemistry this year is unlike anything I have seen before," said captain Marcus Thibodeau after Monday night''s 5-2 victory over the Ice Storm. "Everyone is buying in and playing their role."

The Polar Bears clinched first place in the standings last week and are looking forward to the remaining playoff-bound matchups in March. With the Ice Storm trailing in second and the Frozen Few surging into third, the final three weeks of the regular season promise exciting broomball action.',
    'League Reporter'
  ),
  (
    'Ice Storm Riding a Five-Game Winning Streak',
    'ice-storm-winning-streak',
    '2026-01-14',
    'The Ice Storm have rattled off five consecutive wins to climb into playoff position.',
    'What started as a rough November has turned into a stellar January for the Ice Storm. After dropping their first two games of the season, the Ice Storm have caught fire and won five straight, moving them to second place in the standings.

Priya Mehta has been the catalyst, potting 8 goals during the streak and earning co-player of the week honours twice. "Priya has been incredible," said Ice Storm coach Dana Sullivan. "She is seeing the ice at a different level right now."

The Ice Storm face the Frozen Few on February 3rd in what is shaping up to be a critical head-to-head matchup for playoff seeding.',
    'League Reporter'
  ),
  (
    'Winter 2025-2026 Season Preview',
    'winter-2025-2026-preview',
    '2025-11-01',
    'All five teams are ready for a competitive season as the puck drops on Winter 2025-2026.',
    'The District Broomball League kicks off its Winter 2025-2026 season this Monday at the Rideau Rink. All five teams have been busy preparing through the offseason and early practices, and league officials expect another exciting campaign.

**Teams to Watch**

The Polar Bears return their core group from last season''s runner-up finish and have added two key players. The Ice Storm made the most offseason changes, bringing in four new faces. The Frozen Few, last year''s champions, are looking to repeat. The Cold Fronts and Arctic Wolves both promise to be competitive.

The regular season runs through March 16th, with playoffs to follow. Come out and support your team!',
    'League Commissioner'
  ),
  (
    'Frozen Few Claim Winter 2024-2025 Championship',
    'frozen-few-champions-2025',
    '2025-03-12',
    'The Frozen Few edged the Polar Bears 3-2 in overtime to win the league championship.',
    'The Frozen Few are the District Broomball League champions for Winter 2024-2025, defeating the Polar Bears 3-2 in a nail-biting overtime final at the Rideau Rink on March 10th.

Nadia Volkov''s overtime winner at 4:37 of the extra period sent the Frozen Few bench into a celebration. "This group worked so hard all season," said Volkov, who led all playoff scorers. "We believed we could do this since day one."

The Polar Bears put up a valiant effort in the final, with Marcus Thibodeau scoring both regulation goals. The league championship trophy will be engraved and presented at the season-opening banquet in November.

Congratulations to the Frozen Few on a tremendous championship season!',
    'League Commissioner'
  ),
  (
    'New This Season: Updated Penalty Rules',
    'updated-penalty-rules-2025',
    '2025-10-15',
    'The league has updated several penalty guidelines ahead of the Winter 2025-2026 season.',
    'The District Broomball League Rules Committee has approved several updates to the penalty guidelines for the upcoming Winter 2025-2026 season. These changes aim to improve game flow and player safety.

**Key Changes:**

1. **Slashing** — Minor penalties will now be assessed for slashing on the hand or wrist, regardless of intent. Previously this was discretionary.

2. **Body Contact** — The no-contact rule continues, with referees instructed to be more proactive in calling incidental contact before it escalates.

3. **Delay of Game** — A new delay of game penalty will be assessed when a player intentionally shoots the ball out of the rink after an opposing team''s faceoff win.

Full updated rules are available in the Info section of this website. All players are encouraged to review the changes before the season begins.',
    'Rules Committee'
  );

-- Info pages
INSERT INTO pages (section, slug, title, summary, body, sort_order) VALUES
  (
    'info', 'about',
    'About the League',
    'History and overview of the District Broomball League.',
    'The District Broomball League has been running competitive recreational broomball in the Ottawa area since 2010. What started as a single division of four teams has grown into a five-team league with three full seasons per year.

## Our Mission

We provide a fun, safe, and competitive broomball environment for adult recreational players. Whether you are a seasoned veteran or picking up a broom for the first time, the DBL is the place to play.

## Season Structure

Each winter season runs from November through March. Teams play a full round-robin schedule before a single-elimination playoff. Championship banquets and trophy presentations follow each season.

## History

The league was founded in 2010 by a group of friends at the Rideau Rink. Since then, we have welcomed over 100 players across all skill levels. The Frozen Few and Polar Bears hold the most championships with three each.',
    1
  ),
  (
    'info', 'rules',
    'League Rules',
    'Official rules and regulations for the District Broomball League.',
    '## General Rules

All games are played under the official Broomball Canada rules with the following league-specific modifications:

## Game Format

- **Game Duration:** Two 25-minute halves with a 5-minute intermission
- **Overtime:** 5-minute sudden-death overtime in regular season; full 10-minute periods in playoffs until a goal is scored
- **Team Size:** 5 skaters + 1 goalie; minimum 4 skaters to start a game

## Equipment

- All players must wear a certified helmet with a full cage or visor
- Gloves are mandatory for all skaters
- Shin pads and elbow pads are strongly recommended
- Broomball-specific shoes or rubber-soled footwear required — no skates

## Contact Rules

This is a **non-contact league**. The following result in minor penalties:

- Body checking or intentional body contact
- Slashing (any contact with another player''s body using the broom)
- Hooking or holding
- Interference

## Goalie Rules

- Goalies may not be body checked at any time — automatic minor + 10-minute misconduct
- The crease is a protected area: opposing players may not enter unless the ball is there

## Scoring

- Win = 2 points
- Tie = 1 point
- Loss = 0 points
- Overtime Win = 2 points; Overtime Loss = 1 point

## Conduct

All players are expected to demonstrate good sportsmanship at all times. Excessive arguing with officials will result in a misconduct penalty. Physical altercations will result in an automatic game suspension pending a review by the Rules Committee.',
    2
  ),
  (
    'info', 'schedule-format',
    'Season Schedule & Format',
    'How the season schedule and playoffs work.',
    '## Regular Season

The regular season consists of a full round-robin schedule, with each team playing every other team multiple times. All games are played at the Rideau Rink.

**Typical game nights:** Monday evenings, with games at 8:00 PM and 9:30 PM.

## Standings & Tiebreakers

Playoff seeding is determined by the following, in order:

1. Total points
2. Wins
3. Head-to-head record
4. Goal differential
5. Goals for

## Playoffs

The top four teams qualify for the playoffs, which are held in the final two weeks of March. The playoff format is single elimination:

- **Semifinals:** 1st vs 4th seed, 2nd vs 3rd seed
- **Championship Final:** Top two semifinal winners

Playoff overtime rules: full 10-minute periods are played until a goal is scored. There are no shootouts.

## Awards

At the season-closing banquet, the following awards are presented:

- **Championship Trophy** — winning team
- **Scoring Champion** — most regular-season points
- **Most Valuable Player** — voted by players and league staff
- **Best Goalie** — lowest goals-against average (minimum 8 games played)
- **Sportsmanship Award** — voted by players',
    3
  ),
  (
    'info', 'registration',
    'Registration & Fees',
    'How to register and what the seasonal fees cover.',
    '## How to Register

Registration for the upcoming season opens on October 1st. You can register as an individual or as a full team.

**Individual registration:** Players are placed on teams by the league based on experience level and team balance.

**Team registration:** An existing team may register together. Teams must have a minimum of 8 players and a maximum of 14.

## Fees

| Registration Type | Fee |
|---|---|
| Individual player | $120/season |
| Full team (8–14 players) | $900/season |

Fees cover ice rental, referee costs, equipment insurance, and the end-of-season banquet.

## Payment

Payment is due at the time of registration. We accept e-transfer to league@districtbroomball.ca or cheque made out to "District Broomball League."

## Cancellation Policy

Full refunds are available up to 4 weeks before the season start date. After that, a 50% refund is available up to 1 week before the season. No refunds after the season begins.

## Questions?

Contact the league at league@districtbroomball.ca or speak with the league commissioner at any game night.',
    4
  ),
  (
    'info', 'contact',
    'Contact Us',
    'How to reach the league organizers.',
    '## Contact Information

**League Commissioner:** Alex Pemberton
**Email:** league@districtbroomball.ca

**Primary Rink:**
Rideau Rink
123 Rideau Street
Ottawa, ON K1N 5Y1

## Game Night Questions

For questions on game night — including score disputes, postponements, or equipment issues — speak directly with the on-ice officials or find a league representative at the scorer''s table.

## Social Media

Follow us online for live score updates, news, and announcements:

- Instagram: @districtbroomball
- Facebook: facebook.com/districtbroomball

## Mailing List

To receive league announcements by email, contact us at the address above and ask to be added to the mailing list.',
    5
  );

-- Season 1 player stats (partial, for all-time stats)
INSERT INTO player_game_stats (game_id, player_id, goals, assists, penalty_minutes)
SELECT g.id, p.id,
  CASE WHEN (g.id + p.id) % 5 = 0 THEN 2
       WHEN (g.id + p.id) % 3 = 0 THEN 1
       ELSE 0 END,
  CASE WHEN (g.id + p.id) % 4 = 0 THEN 2
       WHEN (g.id + p.id) % 2 = 0 THEN 1
       ELSE 0 END,
  CASE WHEN (g.id + p.id) % 7 = 0 THEN 2
       ELSE 0 END
FROM games g
CROSS JOIN players p
WHERE g.season_id = 1
  AND p.team_id IN (g.home_team_id, g.away_team_id)
  AND p.position != 'goalie';
