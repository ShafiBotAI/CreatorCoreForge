#!/bin/sh
set -e
if [ -z "$SLACK_WEBHOOK" ]; then
  echo "SLACK_WEBHOOK not set" && exit 0
fi
curl -X POST -H 'Content-type: application/json' --data "{\"text\": \"$1\"}" "$SLACK_WEBHOOK"
