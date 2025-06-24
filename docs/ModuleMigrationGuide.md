# Module Migration Guide

This guide describes how to migrate existing apps to use the shared engines and services introduced in Phase 8.

## Core Libraries
- **FusionEngine** – Handles AI routing and context. Replace direct `OpenAIService` calls with `FusionEngine` when you need adaptive prompts or local/offline support.
- **LocalAIEnginePro** – Lightweight on-device model. Set the `USE_LOCAL_AI` environment variable to enable this engine for offline development.
- **LocalVoiceAI** – Provides voice cloning and TTS without an internet connection. Instantiate `LocalVoiceAI()` in place of remote services when offline.

## Migration Steps
1. Import the `CreatorCoreForge` Swift package into your project.
2. Replace previous direct service usages with the new shared modules above.
3. Review existing code for duplicate implementations and remove them.
4. Run `swift test` and the lab `npm test` commands to verify everything works.

Refer to `AI-Prompt-Migration.md` for guidance on updating prompt templates.
