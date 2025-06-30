#!/bin/sh
set -e
LOG_FILE=$1
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Missing GITHUB_TOKEN" && exit 0
fi
if [ ! -f "$LOG_FILE" ]; then
  echo "No log file" && exit 0
fi
if grep -q "ERROR" "$LOG_FILE"; then
  gh issue create -t "CI Failure" -b "See logs:\n\n\`$(tail -n 50 "$LOG_FILE")\`"
fi
