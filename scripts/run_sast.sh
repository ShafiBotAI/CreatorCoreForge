#!/usr/bin/env bash
set -e
if command -v swift >/dev/null 2>&1 && command -v swift-scan >/dev/null 2>&1; then
  swift package resolve
  swift-scan scan --build --scheme CreatorCoreForge
else
  echo "swift-scan not available"
fi
