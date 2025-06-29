#!/usr/bin/env bash
set -euo pipefail
for dir in apps/*/Desktop; do
  if [ -f "$dir/package.json" ]; then
    echo "Packaging $dir"
    pushd "$dir" >/dev/null
    npm install
    npx electron-builder
    popd >/dev/null
  fi
done
