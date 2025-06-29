#!/usr/bin/env bash
set -euo pipefail
commit=$(git rev-parse --short HEAD)
TAG="canary-$commit"
echo "Preparing $TAG"
# create canary tag
git tag "$TAG"
# check error rate (placeholder)
error_rate=$(grep -c "ERROR" logs/app.log 2>/dev/null || echo 0)
if [ "$error_rate" -gt 0 ]; then
  echo "Error rate $error_rate detected, rolling back"
  git tag -d "$TAG" || true
  exit 1
fi
echo "Canary release $TAG ready"
