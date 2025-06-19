# Agent: Full Feature Integration – CoreForge Audio

## Description
This agent is responsible for building, validating, and maintaining every core feature of the CoreForge Audio application. It ensures integration with all APIs, complete UI/UX polish, platform parity, and seamless data flows for users and backend services. This file provides a full checklist of all features required for code completion and OpenAI Codex agent collaboration.

## Objectives
- Complete app functionality end-to-end
- Match all described features in the app's design specification
- Support for iOS, Android, PC, macOS, and Web platforms
- Enable multilingual support, NSFW gating, offline content, and monetization systems

## Core Features (Detailed)

### Core Functionalities
- [x] Import ePub/PDF and detect chapters
- [x] Assign voices to characters and remember across series
- [ ] Create downloadable audiobooks (Codex)
- [x] Offline playback and vault system
- [x] NSFW content toggle with parental PIN lock

### AI & API Integration
- [ ] OpenAI GPT-based chapter segmentation and narration (Codex)
- [ ] ElevenLabs voice rendering and streaming (Codex)
- [x] Character memory and reuse from metadata

### UX/UI Components
- [x] Dark mode & theme toggle
- [ ] Audiobook player with seek/bookmark (Codex)
- [x] Settings screen for voice & NSFW filters


## System Integration Requirements
- [ ] OpenAI API integration (with prompt templating, key management, streaming where needed) (Codex)
- [ ] Firebase integration (Auth, Firestore, Storage) (Codex)
- [ ] ElevenLabs voice API (where applicable) (Codex)
- [ ] Platform-specific permissions and environment configuration (Codex)
- [ ] Secure API key handling and compliance with data protection policies (Codex)
- [ ] Fix and complete the `.pbxproj` project file (Codex)

## Testing Requirements
- [ ] Unit tests for all critical functions (Codex)
- [ ] Integration tests for API workflows (Codex)
- [ ] Prompt validation with example inputs/outputs (Codex)
- [ ] UI interaction tests (iOS, Android, Web) (Codex)
- [ ] Performance and latency benchmarks (Codex)
- [ ] Security audit for data handling and API access (Codex)

## Deployment & CI/CD
- [ ] GitHub Actions for multi-platform builds (iOS, Android, PC, Mac) (Codex)
- [ ] Version tagging and changelogs (Codex)
- [ ] TestFlight, Play Store internal, and Google Drive delivery automation (Google Drive script added) (Codex)
- [ ] Auto-updater system embedded in all installers (Codex)

## Documentation
- [x] README.md per app
- [x] PromptTemplates.md with sample prompts
- [x] APISetup.md for all third-party keys and integrations
- [x] DeveloperSetup.md for local environment instructions

### Global Missing Items
- [x] Integrate shared `autoUpdater.swift`
- [ ] Generate full `.pbxproj` project
- [ ] Provide App Store assets and launch screens
- [ ] Finalize production UI components
- [ ] Build `.dmg` and `.exe` installers


### Phase 4 Features
#### Audio Personalization
- [ ] Implement replay analytics for all audio lines (replay, skip, loop stats)
- [ ] Add "Sleep Read Mode" with ambient fade and timer
- [ ] Create emotion-shift tracker graph for narrated content
- [ ] Build voice rating/review system for listeners
- [ ] Add auto-casting engine to assign optimal voices by genre
- [ ] Enable pronunciation override per word with phoneme editing UI
- [ ] Schedule narration tasks per user time zone

#### Playback Innovation
- [ ] Build dynamic audio ad insertion engine for monetized public books
- [ ] Create dual-language narration engine (e.g., English-Spanish)
- [ ] Enable auto split/merge of audio chapters
- [ ] Timeline editor for advanced pause/voice control
- [ ] Whisper-to-normal conversion system
- [ ] Personalized greeting intros based on user profile
- [ ] Voice archive per user (download past sessions)

#### Interactive/Hybrid Features
- [ ] Remix mode: shuffle POVs and playback order
- [ ] Accessibility output to Braille printer
- [ ] Apple Watch mini controller sync
- [ ] In-book voice polls (vote on tone delivery)
- [ ] Heart-rate based voice delivery (via wearables)
- [ ] Unlockable voice skins, accents, FX presets
=======
### Upcoming Features
- [ ] Embed `LocalVoiceAI Advanced Mode`
- [ ] Add emotion pacing editor (by paragraph, chapter)
- [ ] Integrate smart ambient mixer (rain, wind, fire SFX)
- [ ] Add 3D spatial audio and ASMR tone presets
- [ ] Enable NSFW whisper tone with auto-detection
- [ ] Build audiobook export engine (MP3/WAV/SRT)
- [ ] Create voice glossary and bookmark UI
- [ ] Add group "Live Read" room functionality
- [ ] Sync playback position across devices
- [ ] Integrate Creator Commentary and Podcast export
- [ ] Connect scene tone to emotion visualizer
- [ ] Add AI Singing Mode + tone dial
- [ ] Add "Recast voice" feature to reread chapters in alternate tones/styles

