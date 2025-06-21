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
    swift package generate-xcodeproj
    popd >/dev/null
  fi
  echo "----"
done
