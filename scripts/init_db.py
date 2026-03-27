#!/usr/bin/env python3
"""
init_db.py — Initialize the District Broomball League database.
Creates the database, applies the schema, and loads seed data.

Usage:
    python3 scripts/init_db.py [--db PATH] [--reset]
"""
import argparse
import os
import sqlite3
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR   = os.path.dirname(SCRIPT_DIR)

DEFAULT_DB   = os.path.join(ROOT_DIR, 'league.db')
SCHEMA_FILE  = os.path.join(SCRIPT_DIR, 'schema.sql')
SEED_FILE    = os.path.join(SCRIPT_DIR, 'seed.sql')


def init_db(db_path: str, reset: bool = False) -> None:
    if reset and os.path.exists(db_path):
        os.remove(db_path)
        print(f"Removed existing database: {db_path}")

    if os.path.exists(db_path) and not reset:
        print(f"Database already exists at {db_path}")
        print("Use --reset to drop and recreate it.")
        return

    conn = sqlite3.connect(db_path)
    conn.execute("PRAGMA foreign_keys = ON")
    cur = conn.cursor()

    print("Applying schema...")
    with open(SCHEMA_FILE) as f:
        cur.executescript(f.read())

    print("Loading seed data...")
    with open(SEED_FILE) as f:
        cur.executescript(f.read())

    conn.commit()
    conn.close()
    print(f"Database created: {db_path}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Initialize the league database')
    parser.add_argument('--db',    default=DEFAULT_DB, help='Path to the SQLite database')
    parser.add_argument('--reset', action='store_true', help='Drop and recreate the database')
    args = parser.parse_args()

    try:
        init_db(args.db, args.reset)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
