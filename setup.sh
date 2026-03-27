#!/usr/bin/env bash
# setup.sh — First-time setup and build for the District Broomball League site.
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== District Broomball League Site Setup ==="

# Initialize the database
echo ""
echo "Step 1: Initializing database..."
python3 scripts/init_db.py

# Build the site
echo ""
echo "Step 2: Generating content and building site..."
python3 scripts/build.py

echo ""
echo "=== Done! ==="
echo "Site is in: public/"
echo ""
echo "To serve locally:  hugo server  (or: python3 -m http.server 8080 --directory public)"
echo "To rebuild:        python3 scripts/build.py"
echo "To reset the DB:   python3 scripts/init_db.py --reset && python3 scripts/build.py"
