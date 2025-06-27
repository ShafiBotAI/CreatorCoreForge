#!/usr/bin/env bash
set -euo pipefail

# Clone or update the audiobookshelf server for local library management.
# The repository is placed under external/audiobookshelf.

TARGET_DIR="external/audiobookshelf"
REPO_URL="https://github.com/advplyr/audiobookshelf.git"

if [ -d "$TARGET_DIR" ]; then
  echo "Updating existing audiobookshelf repository..."
  git -C "$TARGET_DIR" pull --ff-only
else
  echo "Cloning audiobookshelf repository..."
  mkdir -p external
  git clone --depth=1 "$REPO_URL" "$TARGET_DIR"
fi

# Display the first few lines of the license for reference.
cat "$TARGET_DIR"/LICENSE | head -n 5
