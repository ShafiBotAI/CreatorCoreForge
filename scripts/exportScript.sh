#!/usr/bin/env bash
# Simple bulk export script for VisualLab
# Designed for cross-platform compatibility (macOS, Linux, Windows via WSL).
set -euo pipefail

SRC_DIR=${1:-exports}
OUT_DIR=${2:-dist}
mkdir -p "$OUT_DIR"

FFMPEG_BIN="ffmpeg"
command -v "$FFMPEG_BIN" >/dev/null 2>&1 || {
  if command -v ffmpeg.exe >/dev/null 2>&1; then
    FFMPEG_BIN="ffmpeg.exe"
  else
    echo 'ffmpeg not installed'
    exit 1
  fi
}

for vid in "$SRC_DIR"/*.mp4; do
  [ -f "$vid" ] || continue
  base=$(basename "$vid" .mp4)
  "$FFMPEG_BIN" -i "$vid" "$OUT_DIR/$base.gif" -y >/dev/null 2>&1
  cp "$vid" "$OUT_DIR/"
done

echo "Export complete to $OUT_DIR"
