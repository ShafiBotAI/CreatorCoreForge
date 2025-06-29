#!/usr/bin/env bash
set -e
if command -v sonar-scanner >/dev/null 2>&1; then
  sonar-scanner
else
  echo "sonar-scanner not available"
fi
