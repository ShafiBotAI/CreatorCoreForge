# 📋 Baseline Requirements

This document outlines the minimal setup required to build and run **CoreForge Audio**.

## Build Tools
- Xcode 15 or later (Swift 5.9)
- Node.js 18 for scripts
- Python 3.11 for utility scripts

## Environment Variables
- `OPENAI_API_KEY` – for AI narration features
- `ELEVEN_API_KEY` – for ElevenLabs voice synthesis
- `USE_LOCAL_AI` – set to `1` to enable offline mode

## Setup Steps
1. Run `swift package resolve` to fetch dependencies.
2. Open `CoreForgeAudio.xcodeproj` and build the **CoreForgeAudio** scheme.
3. Execute `npm test` from the repo root to ensure shared packages pass.

These requirements align with the repo-wide AGENTS checklist and provide a baseline for all contributors.
