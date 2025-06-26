# 📋 Baseline Requirements

This document outlines the minimal setup required to build and run **CoreForgeMarket**.

## Build Tools
- Xcode 15 or later (Swift 5.9)
- Node.js 18 for scripts
- Python 3.11 for utility scripts

## Environment Variables
- `USE_LOCAL_AI` – set to `1` to enable offline mode

## Setup Steps
1. Run `swift package resolve` if using Swift packages.
2. Open the project file or run `npm install`.
3. Execute `npm test` or `swift test` to verify the build.

These requirements align with the repo-wide AGENTS checklist and provide a baseline for all contributors.
