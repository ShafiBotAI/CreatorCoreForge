#!/usr/bin/env bash
set -euo pipefail

# Export CoreForge Audio app into a standalone repo directory.
# Usage: ./scripts/export_coreforge_audio_repo.sh /path/to/output

DEST=${1:-../CoreForgeAudio}
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -e "$DEST" ]; then
  echo "Destination $DEST already exists. Remove it or choose another path." >&2
  exit 1
fi

mkdir -p "$DEST"

# Copy only the CoreForge Audio app and necessary shared sources.
cp -R "$REPO_ROOT/apps/CoreForgeAudio" "$DEST/"
cp -R "$REPO_ROOT/Sources" "$DEST/"
cp "$REPO_ROOT/Package.swift" "$DEST/"

# Initialize a new git repository if git is available.
if command -v git >/dev/null 2>&1; then
  git -C "$DEST" init >/dev/null
  git -C "$DEST" add .
  git -C "$DEST" commit -m "Initial import of CoreForge Audio" >/dev/null
fi

echo "CoreForge Audio exported to $DEST"
