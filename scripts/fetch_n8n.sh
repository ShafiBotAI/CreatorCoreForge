#!/usr/bin/env bash
set -euo pipefail

# Clone or update the n8n automation engine for local workflow integration.
# The repository is placed under external/n8n.

TARGET_DIR="external/n8n"
REPO_URL="https://github.com/n8n-io/n8n.git"

if [ -d "$TARGET_DIR" ]; then
  echo "Updating existing n8n repository..."
  git -C "$TARGET_DIR" pull --ff-only
else
  echo "Cloning n8n repository..."
  mkdir -p external
  git clone --depth=1 "$REPO_URL" "$TARGET_DIR"
fi
cat "$TARGET_DIR"/LICENSE.md | head -n 5

