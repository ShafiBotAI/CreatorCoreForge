#!/usr/bin/env bash
# Fetch multiple plugin repositories listed in a text file.
set -euo pipefail

LIST_FILE=${1:-"$(dirname "$0")/plugin_list.txt"}
DEST_DIR=${2:-"plugins"}

mkdir -p "$DEST_DIR"
while IFS= read -r repo || [[ -n "$repo" ]]; do
  [[ -z "$repo" ]] && continue
  echo "Fetching $repo"
  python3 "$(dirname "$0")/pull_plugins.py" "$repo" "$DEST_DIR"
done < "$LIST_FILE"
