#!/usr/bin/env bash
set -e
for dir in VisualLab VoiceLab apps/CoreForgeBuild; do
  if [ -f "$dir/tsconfig.json" ]; then
    (cd "$dir" && npx tsc --noEmit)
  fi
done
