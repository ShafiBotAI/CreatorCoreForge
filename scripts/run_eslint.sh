#!/usr/bin/env bash
set -e
npx eslint "**/*.{ts,tsx,js}"
npx prettier --check "**/*.{ts,tsx,js,json,md}"
