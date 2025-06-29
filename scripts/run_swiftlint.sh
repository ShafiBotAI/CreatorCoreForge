#!/usr/bin/env bash
set -e
if command -v swiftlint >/dev/null 2>&1; then
  swiftlint --config .swiftlint.yml
else
  echo "SwiftLint not installed"
fi
if command -v swiftformat >/dev/null 2>&1; then
  swiftformat --config .swiftformat.yml --lint .
else
  echo "SwiftFormat not installed"
fi
