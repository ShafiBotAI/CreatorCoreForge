#!/usr/bin/env bash
set -e
if command -v snyk >/dev/null 2>&1; then
  snyk test || true
else
  echo "snyk not available"
fi
