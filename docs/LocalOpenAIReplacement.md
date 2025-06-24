# Local OpenAI Replacement Guide

This guide explains how CreatorCoreForge provides OpenAI–level capabilities entirely offline through its built‑in modules. Use these steps to enable the same features across every app without relying on external APIs.

## Core Modules

- **LocalAIEnginePro** – Handles text generation, summarization, embeddings, sentiment analysis, and multilingual chat completions. Enable this engine by setting `USE_LOCAL_AI=1` in your environment.
- **LocalVoiceAI** – Performs voice cloning and speech synthesis locally with emotion control.
- **FusionEngine** – Routes prompts to either the local engines or remote services. When `USE_LOCAL_AI` is set, FusionEngine automatically selects the offline modules.
- **AIStateTracker** – Maintains short‑term memory and context so prompts remain consistent across sessions.
- **VoiceTrainer** – Allows custom voice model training completely offline.

## Integration Steps

1. Add `CreatorCoreForge` as a package dependency and import the shared modules in your app.
2. Set the environment variable `USE_LOCAL_AI=1` before building or running tests.
3. Replace direct `OpenAIService` calls with `FusionEngine` as described in `ModuleMigrationGuide.md`.
4. Use `LocalVoiceAI` for speech synthesis and cloning tasks.
5. Run `swift test` and `npm test` to confirm the offline engines are working as expected.

## Features Enabled

- Chat and completion style responses
- Text summarization and embeddings queries
- Local sentiment and emotion analysis
- Voice generation with emotion modulation
- Cross‑app memory via `VoiceMemoryManager` and `AIStateTracker`

With these modules enabled, every CreatorCoreForge application can replicate the standard OpenAI workflow while remaining fully functional without internet access.
