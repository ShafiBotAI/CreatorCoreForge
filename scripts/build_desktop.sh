#!/usr/bin/env bash
set -euo pipefail

APPS=(CoreForgeAudio CoreForgeVisual CoreForgeWriter CoreForgeStudio CoreForgeLeads CoreForgeMusic CoreForgeBuild)

for APP in "${APPS[@]}"; do
  APP_DIR="apps/${APP}/Desktop"
  if [ -f "$APP_DIR/package.json" ]; then
    echo "Building $APP for macOS and Windows"
    pushd "$APP_DIR" >/dev/null
    npm install
    npx electron-builder --mac --win
    popd >/dev/null
  else
    echo "Skipping $APP - no desktop project found"
  fi
  echo "-----"
done
