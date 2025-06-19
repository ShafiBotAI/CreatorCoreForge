#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <file> <folder_id>"
  exit 1
fi

FILE="$1"
FOLDER_ID="$2"

if [ ! -f "$FILE" ]; then
  echo "File not found: $FILE" >&2
  exit 1
fi

if [ -z "${GDRIVE_TOKEN:-}" ]; then
  echo "GDRIVE_TOKEN environment variable not set" >&2
  exit 1
fi

METADATA=$(jq -n --arg name "$(basename "$FILE")" --arg parent "$FOLDER_ID" '{name:$name, parents:[$parent]}')

curl -s -X POST \
  -H "Authorization: Bearer $GDRIVE_TOKEN" \
  -F "metadata=$METADATA;type=application/json;charset=UTF-8" \
  -F "file=@$FILE;type=application/octet-stream" \
  "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart" >/dev/null

echo "Uploaded $FILE to Google Drive folder $FOLDER_ID"
