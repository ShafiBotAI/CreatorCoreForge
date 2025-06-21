#!/usr/bin/env bash
set -euo pipefail

# Generate Xcode projects for all packages under apps/
for pkg in $(find apps -name Package.swift -print); do
  dir=$(dirname "$pkg")
  if ls "$dir"/*.xcodeproj >/dev/null 2>&1; then
    echo "Skipping $(basename $(dirname $pkg)) - Xcode project already exists"
  else
    echo "Generating Xcode project for $(basename $(dirname $pkg))"
    pushd "$dir" >/dev/null
    if swift package --help | grep -q generate-xcodeproj; then
      swift package generate-xcodeproj || true
    else
      false
    fi
    if [ $? -ne 0 ]; then
      echo "\u26A0\uFE0F  generate-xcodeproj unavailable; copying template"
      name=$(basename "$dir")
      mkdir -p "$name.xcodeproj"
      cp "$(git rev-parse --show-toplevel)/scripts/templates/template.pbxproj" "$name.xcodeproj/project.pbxproj"
    fi
    popd >/dev/null
  fi
  echo "----"
done
