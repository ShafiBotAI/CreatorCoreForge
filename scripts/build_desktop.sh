#!/usr/bin/env bash
set -euo pipefail

APPS=(
  CoreForgeAudio
  CoreForgeVisual
  CoreForgeWriter
  CoreForgeStudio
  CoreForgeLeads
  CoreForgeMusic
  CoreForgeBuild
  CoreForgeMarket
  CoreForgeLearn
  CoreForgeBloom
  CoreForgeDNA
  CoreForgeMind
  CoreForgeQuest
  CoreForgeVoiceLab
)

for APP in "${APPS[@]}"; do
  APP_DIR="apps/${APP}/Desktop"
  if [ ! -f "$APP_DIR/package.json" ]; then
    echo "Skipping $APP - no desktop project found"
    echo "-----"
    continue
  fi

  echo "Building $APP"
  pushd "$APP_DIR" >/dev/null
  npm install

  PLATFORM="$(uname -s)"
  case "$PLATFORM" in
    Darwin*)
      TARGETS="--mac"
      if command -v wine >/dev/null 2>&1; then
        TARGETS="$TARGETS --win"
      else
        echo "wine not found; Windows build skipped."
      fi
      ;;
    MINGW*|MSYS*|CYGWIN*|Windows_NT)
      TARGETS="--win"
      ;;
    Linux*)
      TARGETS="--linux"
      if command -v wine >/dev/null 2>&1; then
        TARGETS="$TARGETS --win"
      else
        echo "wine not found; Windows build skipped."
      fi
      ;;
    *)
      echo "Unsupported platform $PLATFORM. Skipping build."
      popd >/dev/null
      echo "-----"
      continue
      ;;
  esac

  npx electron-builder $TARGETS
  popd >/dev/null
  echo "-----"
done
