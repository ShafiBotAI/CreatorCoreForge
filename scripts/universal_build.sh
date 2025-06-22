#!/usr/bin/env bash
set -euo pipefail

# Build iOS apps using Fastlane
if command -v fastlane >/dev/null 2>&1; then
  echo "Building iOS apps via fastlane"
  (cd fastlane && fastlane build_all)
else
  echo "fastlane not found; skipping iOS build"
fi

# Build Android apps if gradlew files exist
find apps -name gradlew | while read -r gradle_path; do
  app_dir=$(dirname "$gradle_path")
  echo "Building Android app in $app_dir"
  (cd "$app_dir" && ./gradlew assembleRelease)
  echo "-----"
done

# Build Web apps if a Web folder with package.json exists
for web_dir in apps/*/Web; do
  if [ -f "$web_dir/package.json" ]; then
    echo "Building Web app in $web_dir"
    (cd "$web_dir" && npm install && npm run build)
    echo "-----"
  fi
done

# Build desktop installers
./scripts/build_desktop.sh

# Build Chrome extension if present
if [ -d extensions/chrome ]; then
  echo "Building Chrome extension"
  (cd extensions/chrome && npm install && npm run build)
fi

# Build Edge add-on if present
if [ -d extensions/edge ]; then
  echo "Building Edge add-on"
  (cd extensions/edge && npm install && npm run build)
fi

