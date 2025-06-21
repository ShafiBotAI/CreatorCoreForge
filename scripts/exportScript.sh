#!/bin/bash
# Simple bulk export script for VisualLab
set -e
SRC_DIR=${1:-exports}
OUT_DIR=${2:-dist}
mkdir -p "$OUT_DIR"
command -v ffmpeg >/dev/null 2>&1 || { echo 'ffmpeg not installed'; exit 1; }
for vid in "$SRC_DIR"/*.mp4; do
  [ -f "$vid" ] || continue
  base=$(basename "$vid" .mp4)
  ffmpeg -i "$vid" "$OUT_DIR/$base.gif" -y >/dev/null 2>&1
  cp "$vid" "$OUT_DIR/"
done
echo "Export complete to $OUT_DIR"
