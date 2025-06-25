# 🔥 CreatorCoreForge

**Current Major Version:** 2.0.0
**CreatorCoreForge** is a suite of next-generation AI-powered creative, productivity, health, and monetization applications. Built for creators, entrepreneurs, educators, and enterprises, this platform empowers users to generate world-class audio, video, books, mental health experiences, financial strategies, and content—with no external API dependencies.

---

## 🏢 Master Company
**Brand Name:** `CreatorCoreForge`  
**Domain:** `CreatorCoreForge.com`  
**Focus:** AI-first tools across entertainment, wellness, publishing, education, productivity, and finance.

---

## 🔧 Technology Stack
- LocalAIEngine Pro – local text engine with embeddings, summarization, and simple sentiment analysis
- LocalVoiceAI Advanced Mode – offline voice cloning with emotion control
- FusionEngine™ (modular adaptive AI framework)
- QuantumConnector™ (real/simulated quantum support)
- Electron.js (cross-platform PC builds)
- Swift (iOS), Kotlin (Android), Unity (Games)

---

## 📦 App Modules

### 🎙 CoreForge Audio
- **Use Case:** Audiobook generation, voice studio, narration platform
- **Key Features:**
  - Voice cloning, multilingual support, emotion arcs
  - NSFW toggle, narrator marketplace, book upload
  - Offline TTS, phoneme control, lipsync, stealth vault
  - VoiceTimbreModulator for customizable timbre profiles
  - MultiLanguageAccentNarrator enables multi-language and accent erotic narration
  - AIEmotionEngine for dynamic emotion cues
  - GPT-based chapter segmentation and ElevenLabs voice streaming
  - BookImporter now parses TXT, PDF, and EPUB with metadata extraction
  - Downloadable audiobooks with bookmarkable playback
  - Audiobook export engine (MP3/WAV with zip packaging via `AudiobookCompiler`)
  - OfflineTTSCache for local voice caching
  - AnalyticsLogger for basic event tracking
  - PerformanceModeSelector to switch rendering presets
  - FusionVoiceController orchestrates LocalVoiceAI and emotion cues
  - MultiCastAudiobookGenerator enables ensemble narration
  - DramatizedAudiobookProducer creates immersive dramatized audiobooks
  - Extra helpers in `Sources/CreatorCoreForge/CoreForgeAudio_MissingFeatures.swift`
    provide offline download and eBook conversion utilities for the app.
- **Build Status:** Electron PC build in testing

---

### 🎥 CoreForge Visual
- **Use Case:** Book-to-video cinematic AI dramatization
- **Key Features:**
  - Scene adaptation (anime, live-action, fantasy, etc.)
  - ElevenLabs → LocalVoiceAI switch
  - Auto voice sync, character memory, cross-book AI
  - GPT-4 streaming previews and virality engine
  - Scene builder UI with auto-upload scheduler
- **Build Status:** Installer prep phase, full module integration

---

### 📊 CoreForge Market
- **Use Case:** AI-powered trading automation and analysis
- **Key Features:**
  - Titan Engine, Shadow Trading, Whale Wallet Monitoring
  - Insider Flow, Arbitrage Finder, Strategy Blending
  - Optional Tokenomics, Predictive Heatmaps
  - Chart screenshot analysis with emotion-aware journal
  - Multi-market scanning powered by Titan Engine alerts
- **Build Status:** Source files completed, build pending

---

### ✍️ CoreForge Writer
- **Use Case:** AI-powered novel and nonfiction book authoring
- **Key Features:**
  - Adaptive writing style engine, genre presets, twist generator
  - Plot arcs, multilingual export, publishing-ready output
  - Bestseller structure engine with multi-book support
  - Scene builder with NSFW filters and parental locks
- **Build Status:** Agent tasks ready, core models staged

---

### 🧑‍🎤 CoreForge Studio
- **Use Case:** Voice acting, video editing, and AI content studio
- **Key Features:**
  - Auto lip sync, NSFW toggle, split testing, facecam insert
  - Audio+video sync, shortform generation, batch mode
  - Downloadable formats with "What If" cutscene mode
- **Build Status:** Midway through development (Phase 2)

---

### 🧠 CoreForge Mind
- **Use Case:** Men's AI-based wellness and mental health platform
- **Key Features:**
  - AI therapy, sound healing, erotic wellness (18+), journaling AI
  - Always-on companion mode, goal tracking
- **Build Status:** UI prototype in planning

---

### 🌸 CoreForge Bloom
- **Use Case:** AI-powered health & empowerment for women
- **Key Features:**
  - AI coaching, sexual health, hormone sync, wellness analytics
  - Creator monetization, avatar therapy, sound tools
- **Build Status:** Roadmap and feature model complete

---

### 🎶 CoreForge Music
- **Use Case:** Songwriting, beatmaking, and vocal tool
- **Key Features:**
  - Hook generator, AI vocals, beat marketplace
  - Voice studio, licensing engine, virality toolkit
  - Voice cloning with commercial export and label pitch tools
- **Build Status:** UI and fusion agent completed

---

### 🧬 CoreForge DNA
- **Use Case:** Visualize, fork, and evolve AI voices across characters
- **Key Features:**
  - Tree UI, multiverse memory, scene tagging, emotion graphs
  - Vector Voice DNA Map for embedding-based visualization
- **Build Status:** Standalone version in pipeline

---

### 🧪 CoreForge Voice Lab
- **Use Case:** Upload, train, and fine-tune custom AI voices
- **Key Features:**
  - Voice-to-voice transfer, tone control, phoneme editing
  - Style-preserving translation, NSFW tone synthesis
  - Local voice training with the `VoiceTrainer` engine
- **Build Status:** Embedded version complete; standalone in progress

---

### 🧩 CoreForge Build
- **Use Case:** Low-code AI-driven app builder for creators
- **Key Features:**
  - Templates, plugin generator, AI agent builder
  - White label deployment, monetization toggles
  - Trend-based app ideation and Figma-driven UI builder
- **Build Status:** Agents.md + structure in progress

---

### 🧠 CoreForge Leads *(formerly DataForge AI)*
- **Use Case:** AI B2B lead generation, sales automation & analytics
- **Key Features:**
  - AI deal coach, lead scoring, retargeting, lead resale exchange
  - CRM integrations, tokenomics, affiliate dashboards
  - Real-time signal tracking with multilingual targeting
- **Build Status:** Launch bundle assembling now

---

### 🧠 CoreForge Quest *(formerly Crush Quest)*
- **Use Case:** Puzzle game + AI assistant + viral reward engine
- **Key Features:**
  - $25M Level 1M Challenge, map vault, offline vault
  - Creator leaderboards, reward monetization
- **Build Status:** Unity build + legal/promo kit bundled

---

## 🔮 Shared Modules & Features

- **FusionEngine™:** Master AI layer handling:

  - Contextual memory, voice memory, scene generation, parallel cores,
    emotional logic, AI Studio & Genesis hooks, sandbox AI
- **LocalVoiceAI:** Full ElevenLabs replacement with advanced cloning and emotion modulation
- **LocalAIEngine Pro:** OpenAI-free LLM for text, dialogue, and logic
  - Contextual memory, parallel cores, emotional logic, sandbox AI
- **LocalVoiceAI:** Full ElevenLabs replacement with advanced cloning and emotion modulation. Includes offline voice cloning and synthesis APIs.
- **LocalElevenLabsClient:** Mirrors the ElevenLabs API surface to run entirely offline by delegating to `LocalVoiceAI`.
 - **LocalAIEngine Pro:** OpenAI-free LLM for text, dialogue, logic, local summarization, and basic sentiment analysis.

- **QuantumConnector:** Optional quantum computing toggle
- **Virality Engine:** Trend detector, loop optimizer, replay bait, shock factor enhancer
  - Now implemented as a shared module so every app can analyze trending content
    even when offline. `QuantumConnector` performs simple data transformations
    when quantum mode is enabled.
- **Auto-Updater:** Keeps local builds current and secure
- **NetworkInfoProvider:** Retrieves real-time data from remote JSON endpoints
  with a simple API.
- **AIStateTracker:** Learns from prompt history locally for adaptive responses
- **Creator Dashboard:** Toggle Voice Memory, Emotion Graphs, Plugin Builder, AI Studio, Genesis, Global Unlock, and Sandbox tools across apps
- **EmotionGraph:** Cross-app tracker for character emotion intensity
- **EmotionalArcTracker:** Records emotion intensity for characters over time

- **EmotionHeatmap:** Generates normalized emotion intensity heatmaps from text
- **EmotionDatabase:** Shared dictionary of emotion records and synonyms used by
  CoreForge Audio, Visual, Writer, and Mind for emotion cues

- **NSFWMoodHeatmap:** Normalizes logged NSFW intensity levels for analytics

- **SceneGenerator:** Converts text into basic storyboard scenes
- **VoiceMemoryManager:** Shares voice assignments across apps
- **VoiceTrainer:** Uploads and trains custom voice models locally for offline voice synthesis.
- **VoiceDNAVisualizer:** Graphs voice relationships and generates Vector Voice DNA Maps.
- **VoiceDNAForker:** Creates pitch and speed-based voice variations from a base profile.

- **VoiceDNAForge:** Stores voice DNA profiles including pitch, cadence, style tags, emotion ranges, and linked characters.
- **UnifiedAudioEngine:** Global volume and mute control with fade transitions for all apps
- **UnifiedVideoEngine:** Cross-platform video rendering wrapper
- **AdaptiveLearningEngine:** Tracks lesson progress for personalized learning

- **PluginBuilder:** Generates basic plugin templates for new dashboard modules
- **AIStudioMode:** Adds a studio prefix to prompts when testing features
- **GenesisModeEngine:** Produces variant ideas for apps and content
- **SelfRepairEngine:** Scans all app folders and fixes simple `fatalError` placeholders via `BuildImprovementEngine`.

---

## 📄 Repo Instructions for Codex & Devs

- Every `/AppFolder` contains:
  - `README.md` = summary, roadmap
  - `agents.md` = Codex task list (Phase 1–7)
  - `/source` = current code base
- All AI engines run locally or via in-app download (no 3rd-party APIs required)

---

## 🔐 Licensing & Monetization

- Creator, Pro, Enterprise, White Label tiers per app
- In-app credits, NSFW add-ons, voice packs, templates
- Referral, affiliate, and creator monetization models included

---

## 🚧 Current Build Status

| App               | PC Build | Mobile Build | AI Modules | Installer Ready |
|------------------|----------|--------------|------------|-----------------|
| CoreForge Audio   | 🟨 In Progress | 🟥 Not Started | ✅ Complete | 🟨 Testing     |
| CoreForge Visual  | 🟨 In Progress | 🟥 Not Started | ✅ Complete | 🟨 Testing     |
| CoreForge Market  | 🟥 Not Started | 🟥 Not Started | ✅ Embedded | ⬜ Planned     |
| CoreForge Writer  | 🟥 Not Started | 🟥 Not Started | 🟨 Drafting | ⬜ Planned     |
| CoreForge Studio  | 🟨 Mid Dev     | 🟥 Not Started | 🟨 Partial  | ⬜ Planned     |
| CoreForge Mind    | 🟥 Not Started | 🟥 Not Started | 🟨 Planned  | ⬜ Planned     |
| CoreForge Bloom   | 🟥 Not Started | 🟥 Not Started | 🟨 Planned  | ⬜ Planned     |
| CoreForge Leads   | 🟨 Finalizing  | 🟥 Not Started | ✅ Complete | 🟨 Compiling   |
| CoreForge Quest   | 🟨 Unity Build | 🟨 Mobile Test | ✅ Complete | 🟨 Unity       |

---

## 🧠 Codex Developer Instructions

See `/agents.md` in each folder for:
- Feature-level tasks
- Build flags (✅ = done, 🟨 = in dev, 🟥 = not started)
- Milestone goals (Phase 1 to Phase 7)
- Phase 8 tasks are tracked in `docs/PHASE_EIGHT.md`

> If you’re a new developer joining this project, start with `CoreForge Audio` and `CoreForge Visual`.

---

## 📬 Contact & Admin

- Master Brand: **CreatorCoreForge**
- Lead: Sarmed Shafi (Director)
- GitHub: [github.com/ShafiBotAI](https://github.com/ShafiBotAI)
- Drive Folder: `CreatorCoreForge`
- AI: FusionEngine™ / LocalAIEngine Pro / LocalVoiceAI Advanced

# -ios-apps


This repository collects multiple experimental iOS projects that integrate AI-driven features. Each app lives under `apps/`.

- **CoreForge Visual** – video and story creation suite. See `apps/CoreForgeVisual/README.md`.
- **CoreForge Audio** – voice-controlled reader with offline vault. See `apps/CoreForgeAudio/README.md`.
- **CoreForge Leads** – data analysis utilities. See `apps/CoreForgeLeads/README.md`.
- **CoreForge Music** – beat and hook generation tools. See `apps/CoreForgeMusic/README.md`.
- **CoreForge Writer** – book publishing assistant. See `apps/CoreForgeWriter/README.md`.
- **CoreForge Market** – trading strategy companion. See `apps/CoreForgeMarket/README.md`.

Recent updates introduce advanced AI stubs across all apps to prepare for next-generation features.
The shared `VoiceMemoryManager` now supports exporting and importing assignments
so creators can sync character voice selections across apps. `FusionEngine`
exposes this manager along with a built-in `SceneGenerator` and hooks for
`AIStudioMode` and `GenesisModeEngine` so each app can reuse the same logic.

TestFlight workflows are provided under `.github/workflows` for continuous delivery.
Pushes to `main` automatically run `fastlane-testflight.yml` which builds **all** iOS
projects under `apps/` and uploads them to TestFlight
using the `build_all` lane. Configure `APPSTORECONNECT_*` secrets in your
repository so the workflow can authenticate with App Store Connect. You can also
manually trigger `upload-testflight.yml` from the Actions tab when a one-off
build is ready for distribution.

For production releases, trigger `upload-appstore.yml` which uses the
`build_all` lane to build every iOS project and submit the resulting
artifacts directly to App Store Connect.

See `docs/AI-Prompt-Migration.md` for integrating the new OpenAI prompt interface across apps.
See `docs/LocalOpenAIReplacement.md` for a primer on using the LocalAI engines to mimic OpenAI features without an internet connection.
See `docs/VoiceTrainerGuide.md` for using the local voice training engine.
See `docs/ModuleMigrationGuide.md` for adopting shared Phase 8 modules across apps.
All apps now include a `VideoShareManager` for posting generated videos directly to social media.

An accompanying `VideoEffectsPipeline` adds fade transitions, watermarking, and frame interpolation so every generated clip looks professional across apps.
An accompanying `VideoEffectsPipeline` adds fade transitions, fade-in/out effects, and watermarking so every generated clip looks professional across apps.

The new `AudioEffectsPipeline` provides echo and pitch-shift utilities so exported audio sounds consistent across apps.
The new `FusionEngine` wrapper automatically selects between `LocalAIEnginePro` and `OpenAIService` for each app, enabling offline-first development when `USE_LOCAL_AI` is set. It now supports contextual memory, parallel execution across multiple engines, emotion tracking, sandbox mode for isolated testing, cross-app voice memory, on-device summarization, and quick scene generation helpers.


## OpenAI Setup

Copy `.env.example` to `.env` and provide your `OPENAI_API_KEY` before running any app or tests. The shared `OpenAIService` reads this value at runtime.
A shared `ContentPolicyManager` now manages NSFW filtering across apps.
The new `NSFWManager` tags sensitive voice clips and enables stealth exports when unlocked.
The `NSFWHabitBehaviorSimulator` lets characters respond with custom audio cues when certain keywords are spoken.
For offline development you can set `USE_LOCAL_AI=1` in the environment to enable `LocalAIEnginePro`, a lightweight local model stub that replaces OpenAI calls.
When this flag is active, both audio and video generation rely entirely on the
local engines (`LocalVoiceAI` and the video routines in `CreatorCoreForge`), so
clips and narration can be produced without any network connection.

## App Store Compliance

For iOS builds, features that provide explicit NSFW content or haptic device integration are disabled. Age gating and parental controls remain enabled so the apps meet Apple's App Store Review Guidelines.
Data usage complies with privacy requirements, and only finalized, non-spammy features are shipped.
See [docs/AppStore_Compliance.md](docs/AppStore_Compliance.md) for more information.
See [docs/AppStore_Upload_Scheme.md](docs/AppStore_Upload_Scheme.md) for per-app upload details.

## Global Missing Items

The following components are planned across all apps but are still works in progress:

- [x] Shared `AutoUpdater.swift` module
- [x] Programmatically generated `.pbxproj` project files
- [x] App Store assets (`AppIcon.appiconset`, LaunchScreens)
- [ ] Final production UI polish
- [x] `.dmg` and `.exe` installers following `.ipa` builds

Run `./scripts/generate_pbxproj.sh` to generate missing Xcode project files for
any Swift packages under `apps/`.
All apps include an `AppStoreAssets` directory containing the icons and launch
screen files used for store submission.

## Desktop Build Script

Cross-platform builds can be generated using `electron-builder`. Run
`./scripts/build_desktop.sh` on macOS or Windows to produce `.dmg` and
`.exe` installers for apps that include a `Desktop` project. macOS and Linux
hosts must have `wine` and `mono` installed to generate the Windows builds.
See
`docs/CrossPlatformBuild.md` for details. For a full multi-platform build (iOS,
Android, Web, Chrome, and Edge) execute `./scripts/universal_build.sh` which
calls the appropriate tools when present.

Each app includes a `Desktop` folder with a starter Electron configuration for
building installers.

## Ebook2Audiobook Integration
A snapshot of the open source `ebook2audiobook` project is included under `apps/ebook2audiobook`. Use the helper script `scripts/ebook2audiobook_bridge.py` to convert eBooks to narrated audio from any CoreForge app:

```bash
./scripts/ebook2audiobook_bridge.py MyBook.epub -o output_audio
```

This invokes the Python pipeline to generate WAV files in the given directory.
## AI Video Generator Integration
A trimmed snapshot of the open source `ai-video-generator` project is included under `apps/AI_VideoGenerator`. Run `python server.py` in that folder to start the FastAPI backend for generating text-to-video clips.


## Chatterbox Script Conversion
Use `scripts/chatterbox_bridge.py` to generate a narrated play from a simple `SPEAKER: line` script. Place `speaker.mp3` samples next to your script and set `CHATTERBOX_API_URL` before running:
```bash
./scripts/chatterbox_bridge.py script.txt
```

Run `scripts/progress_bot.py` to view app progress and generate snippet files for missing features.
Run `scripts/generate_app_completion_report.py` to update `app_completion_report.json` and `docs/App_Completion_Summary.md`.
See `docs/progress_bot.md` for usage details.
## Running Tests

Install Node dependencies for the labs before running the test suites:

```bash
cd VoiceLab && npm install && npm test
cd ../VisualLab && npm install && npm test
cd .. && swift test
```

This ensures `jest`, `ts-node`, and other dev tools are available.


## CI/CD
The repository uses GitHub Actions workflows for building, testing, and releasing the apps across platforms. See the files in [.github/workflows](./.github/workflows) for details.





## Fetching n8n Workflow Engine

Use `./scripts/fetch_n8n.sh` to clone or update the [n8n](https://github.com/n8n-io/n8n) automation engine under `external/n8n`. Review the license printed at the end of the script before integrating it into your projects.


After fetching the repository, you can leverage VoiceLab's `runN8nAssistant` helper to experiment with n8n-inspired AI workflows locally.

