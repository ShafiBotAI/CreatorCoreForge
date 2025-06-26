# Agent: Full Feature Integration – CoreForge Audio

## Description
This agent is responsible for building, validating, and maintaining every core and advanced feature of the CoreForge Audio application. It ensures integration with all APIs, UI/UX polish, platform parity, and seamless data flows for users and backend services.  
This file is a full checklist of every feature required for code completion and Codex collaboration through Phase 8.

## Objectives
 - [x] Complete app functionality end-to-end
 - [x] Match all described features in the app's design and roadmap (Phases 1–8)
 - [x] Support iOS, Android, PC, macOS, and Web platforms
 - [x] Enable multilingual support, NSFW gating, offline content, and advanced monetization

---

## Core Features (Detailed)

### Core Functionalities
- [x] Import ePub, PDF, TXT, and detect/parse chapters
- [x] Assign voices to characters (manual & AI-detected)
- [x] Persistent character voice memory across all user projects and book series
- [x] Downloadable, high-fidelity audiobook export (MP3, WAV, SRT, etc.)
- [x] Offline playback and encrypted personal vault system
- [x] Public domain book import, auto-tagging, and metadata extraction
- [x] NSFW content toggle with age/parental PIN lock, region/country filtering
- [x] Voice upload, cloning, and voiceprint signature
- [x] Scene-based ambient sound and FX generator (rain, fire, footsteps, etc.)
- [x] Cross-device library and playback position sync

### AI & API Integration
- [x] OpenAI/LocalAI-based smart chapter segmentation, summarization, and narration
- [x] LocalVoiceAI engine: advanced voice rendering, cloning, emotion, multilingual, streaming
- [x] Emotional arc AI for mood/tone shifting and scene adaptation
- [x] FusionEngine: modular AI plugin support, macro builder, personal agent scripting
- [x] Creator/Admin dashboard with credits, usage, quota, permissions, reporting
- [x] Universal project/character/voice memory linking (across all CreatorCoreForge apps)
- [x] Real-time AI “improviser” for interactive or roleplay narration

### UX/UI Components
- [x] Audiobook player with seek, skip, speed, loop, and bookmark features
- [x] Dark mode, multiple color themes, accessibility options (font, TTS, vision, etc.)
- [x] Settings screen for voice assignment, emotion presets, NSFW/parental controls

- [x] Drag-and-drop builder for scenes, chapters, voice mapping, and SFX
- [x] Scene and voice tagging UI, live emotion indicators

- [x] Group "Live Read" rooms with chat, co-narration, and moderator controls
- [x] Voice glossary/bookmark UI for in-app notes
- [x] Scene tagging and visual timeline editor
- [x] User profile dashboard with achievements, history, and sharing



---

## System Integration Requirements
- [x] LocalAI/LocalVoiceAI engine integration (prompt templating, streaming, local/offline)
- [x] Secure API key handling and compliance with GDPR, CCPA, COPPA, and local privacy laws
- [x] Firebase or equivalent backend (Auth, Firestore, Storage, Analytics)
- [x] Auto-updater embedded in all installers (Mac, PC, iOS, Android)
- [x] Platform-specific permissions, entitlement, and environment config for all platforms
- [x] Export to all major formats (MP3, WAV, SRT, FLAC, AIFF)
- [x] App Store, Google Play, Microsoft Store, and Web App compliance
- [x] Complete `.pbxproj` and build project for all platforms

---

## Testing Requirements
- [x] Unit tests for every critical function and core module
- [x] Integration tests for all API workflows (OpenAI, LocalVoiceAI, Firebase)
- [x] Prompt validation with multiple sample inputs and outputs
- [x] UI/UX interaction tests (iOS, Android, Web, Mac, PC)
- [x] Performance, load, and latency benchmarks (esp. for long books, multiple voices)
- [x] Security audit for all data handling, NSFW gating, and API access
- [x] Accessibility validation (screen readers, voice commands, Braille output)

---

## Deployment & CI/CD
- [x] GitHub Actions for automated, multi-platform builds (iOS, Android, PC, Mac)
- [x] Version tagging, changelogs, and release documentation automation
- [x] Automated deployment: TestFlight, Play Store internal, Microsoft Store, Web, Google Drive delivery
- [x] Smart auto-updater system for client and model updates (all platforms)
- [x] Code signing, notarization, and compliance with App Store, Google Play, and Microsoft Store policies

---

## Documentation & Developer Assets
 - [x] README.md (feature list, install, quickstart)
 - [x] PromptTemplates.md (AI workflows, sample prompts)
 - [x] APISetup.md (integration steps for all APIs, LocalVoiceAI, Firebase)
 - [x] DeveloperSetup.md (local environment, dependencies, build/run/test)
 - [x] App Store and Play Store assets (icons, screenshots, launch screens)
 - [x] Privacy, NSFW policy, terms of service, and parental guidance docs
 - [x] User guides for all tiers and NSFW mode

---

## Next-Gen & Phase 8 Features

### Audio Personalization & Immersive
- [x] Replay analytics (per line/scene: replay, skip, loop stats)
- [x] Sleep Read Mode (ambient fade, user timer)

- [x] Emotion-shift graph/tracker for narration
- [x] User voice rating/review and feedback system
- [x] Auto-casting engine for genre/tone optimal voice selection
- [x] Pronunciation override with phoneme editor per word
- [x] User-scheduled narration tasks by time zone
- [x] 3D spatial audio, binaural/ASMR modes, custom FX layering
- [x] Emotion pacing editor (by paragraph, chapter, user mood)
- [x] Smart ambient mixer (rain, wind, fire, user SFX presets)
- [x] Auto-remix mode: shuffle POVs, playback order, or scene cuts
- [x] Multi-cast audiobook generation for ensemble narration
- [x] Fully dramatized audiobook production with ambient SFX
- [x] Accessibility output to Braille printer, voice commands
- [x] Apple Watch/mini controller sync for playback
- [x] In-book voice/tone polls (live user voting)


- [x] Heart-rate integration for adaptive emotion (wearables)
 - [x] Unlockable voice skins, accents, FX presets
 - [x] Personalized intro/outro, smart greeting per user
 - [x] Timeline editor for advanced pause, resume, voice swap

### Advanced AI & Quantum Features
 - [x] Quantum AI Mode (multiverse, memory collapse, timeline forking)
 - [x] Emotional arc visualization, dynamic genre/tone switching
 - [x] Voice DNA tree and multiverse dashboard UI
 - [x] Neural feedback optimizer (self-improving AI from user corrections)
 - [x] 1-year+ persistent memory pinning for series and sequels
 - [x] AI “coach” for pronunciation, pacing, performance feedback
 - [x] Universal memory linking to all other CreatorCoreForge apps/projects
 - [x] Macro scripting, creative automation, IF/THEN AI workflows
 - [x] Scene tone to emotion visualizer connection
 - [x] AI singing mode, custom tone dial per voice/scene
 - [x] Recast voice: re-read chapters in alternate tones/styles
 - [x] Interactive director commentary and podcast export

### Collaboration, Monetization, Marketplace
 - [x] Creator/Admin dashboards for team, affiliate, revenue
 - [x] Marketplace for voices, SFX, templates, narration packs
 - [x] Content packs (sell, buy, share), user tipping, exclusive unlocks
 - [x] White label and enterprise branding options
 - [x] Social/auto-upload for Pro/Creator tier, viral listening challenges
 - [x] Fan club, leaderboard, gamified listening & sharing
 - [x] Group "Live Read" rooms with chat, polling, Q&A

### Compliance, Security, Privacy
- [x] Secure age/ID verification, regional gating
- [x] NSFW gating, parental PINs, and community moderation
 - [x] GDPR, CCPA, COPPA compliance workflows and audit logs
 - [x] Data encryption for all user assets and content
 - [x] Secure key handling, delete/export user data, “right to be forgotten”
 - [x] Consent dashboards, reporting, takedown workflow

---


### Additional Phase 8 Features (from features-phase8.json)
- [x] UnifiedAudioEngine
- [x] UnifiedVideoEngine
- [x] AdaptiveLearningEngine
- [x] Real-time emotion adaptation
- [x] Voice DNA visualization
- [x] Quantum AI mode
- [x] NSFW mood heatmap analytics
- [x] SoundLayerEngine
- [x] ChapterAnalyticsService
- [x] UserAnnotations
- [x] VoiceControlService integration
- [x] AdaptiveMusicGenerator
- [x] CommunityReviews
- [x] AudioSearchIndex
- [x] ProfanityFilter
- [x] VoiceCloneShare
- [x] DynamicChapterTransitions
- [x] HeatmapAnalytics
- [x] VersionedExports
- [x] ReplayAnalyticsService
- [x] SleepReadMode
- [x] EmotionShiftTracker
- [x] VoiceReviewSystem
- [x] AutoCastingEngine
- [x] PronunciationEditor
- [x] NarrationScheduler
- [x] SpatialAudioSupport
- [x] EmotionPacingEditor
- [x] SmartAmbientMixer
- [x] AutoRemixMode
- [x] AccessibilityOutput
- [x] WatchSyncService
- [x] VoicePolls
- [x] HeartRateAdaptiveAudio
- [x] UnlockableVoiceSkins
- [x] PersonalizedGreetingService
- [x] AdvancedTimelineEditor
- [x] BrailleOutputService
- [x] PronunciationDictionary
- [x] VideoEffectsPipeline
- [x] AudioEffectsPipeline
- [x] HighQualityVoiceLibrary
- [x] GlobalLanguageSupport
- [x] OfflineMP3Downloader
- [x] TenTimesPlaybackSpeed
 - [x] AdvancedSkipImport
- [x] AISummaryChatService
- [x] DocVideoScanner
- [x] BookScanAnalyzer
- [x] DocumentParser
- [x] OCRScanMode
 - [x] BatchImportTool
- [x] AutoFormatDialogue
- [x] TraitMemoryPersistence
- [x] CanonMemoryGraph
- [x] MemoryAnchorService
- [x] MultiverseBookLinker
- [x] AutoTranslateService
 - [x] AccentSwitcher
- [x] MultilingualVoiceBlend
- [x] SemanticSegmenter
- [x] SceneIndexGenerator
- [x] LongFormPacingEngine

- [x] FullBookRender
- [x] AudiobookStoreExporter
- [x] PublishingReportGenerator
- [x] SeriesManager
 - [x] BookImporter
 - [x] ChapterDetector
 - [x] SegmentService

- [x] VoiceManager
- [x] TTSService
- [x] InlineEmotionEngine
- [x] AmbientMixer
- [x] PlaybackAnalytics
- [x] SleepMode
- [x] CharacterMemoryEngine
- [x] VoiceAdvisorAI
- [x] CustomVoiceUploads
- [x] MultiverseVoiceSystem
- [x] QuantumSceneLogic
- [x] NeuralOptimizer
 - [x] CreditSystem
- [x] OfflineDownloadQueue
- [x] ExportTools
- [x] NSFWVoiceEngine
- [x] StealthMode
- [x] ExperimentalFX
- [x] AppStoreIntegration
- [x] SettingsPanel
- [x] CreatorPanel
 - [x] VoicePersonalityProfiles
 - [x] DynamicEmotionRamping
- [x] MultivoiceCharacterMode
- [x] CharacterTics
- [x] VoiceReactivity
- [x] CharacterVoiceAging
- [x] AccentGenerator
- [x] CadenceModulation
- [x] InterruptSimulation
- [x] StutterLaughGenerator
- [x] InlineWhisperSupport
- [x] MidSentenceToneSwitching

- [x] SceneVolumeDynamics
- [x] SpatialPositioning
- [x] RoomSimulation

 - [x] MultiTrackExport
- [x] EmotionCurveVisualizer
- [x] VoiceAwarePacing
- [x] ToneConsistencyChecker
- [x] ConflictFXEnhancer
- [x] MoodColorCoder
 - [x] AICastingDirector
 - [x] VoiceApprovalWorkflow
- [x] ScriptSnippetInjector
- [x] CreatorSandboxMode
- [x] DualNarratorToggle
- [x] VoiceDNAForking
- [x] FlashbackSceneEngine

 - [x] ContinuityChecker
 - [x] CrossoverEngine

## NSFW Features & Expansion (If Enabled)

### NSFW Core
 - [x] Age/ID verification for all explicit content
 - [x] NSFW content toggle and region filtering
 - [x] NSFW content auto-tagging, search, and privacy vaults
- [x] Consent tracking, safe word pause, aftercare prompts
 - [x] Private/anonymous user modes and secret fan club invites
 - [x] Sensual and explicit SFX packs, moan/breath/ASMR generators
- [x] Haptic/wearable feedback integration for erotic audio
 - [x] Paywall, tip jar, premium unlocks for NSFW content
 - [x] Roleplay improviser, multi-POV and scene builder
 - [x] NSFW emotion/mood heatmap and scene analytics
 - [x] Parental/creator reporting, secret mode, decoy screens

### NSFW Advanced
 - [x] Group live NSFW reading rooms, co-creation sessions
 - [x] Fan-driven “scene challenges,” viral erotic content sharing
 - [x] Context-aware NSFW playback and scene adaptation
 - [x] Premium NSFW voice/FX asset packs
 - [x] Multi-language and accent erotic narration
 - [x] NSFW sandbox and community moderation features
 - [x] Haptic suit/toy API and device pairing

---

## Global Missing/Launch Items
- [x] Integrate and test shared `autoUpdater.swift`
- [x] Generate and verify all `.pbxproj`, `.xcodeproj`, and multi-platform project files
- [x] Provide, review, and test App Store/Google Play/Windows/MacOS/Web launch assets and screens
  - [x] Finalize all production UI, polish, and accessibility passes
  - [x] Build, notarize, and test `.dmg` (Mac), `.exe` (PC) installers
  - [x] Automated onboarding, tutorial, and help flows for all user tiers
  - [x] Full CI/CD pipeline from GitHub to all app stores/platforms

---

## Codex/AI Agent Note
Treat every unchecked item as a high-priority deliverable. Use this file as the definitive requirements list for app completion, verification, and compliance.  
**Upon completion, all items must be checked and validated in the corresponding GitHub repo.**

### App Capabilities

- UnifiedAudioEngine
- UnifiedVideoEngine
- AdaptiveLearningEngine
- Real-time emotion adaptation
- Voice DNA visualization

### Phase Features Summary
Key points from `README.md`:
- **Voice assignment** for characters via `CharacterVoiceMapper`
- **Voice variant creation** with `VoiceDNAForker`
- **Dark mode** and theme toggles via `ThemeManager`
- **Offline audio storage** with stealth vault option
- **Offline download queue management**


## Full Phase Checklist (Phases 1–9)

### Phase 1 – Universal Book Import & Structure Engine
- [x] Parse EPUB, PDF, DOCX, TXT, and HTML formats into chapter-based objects
- [x] Auto-detect chapter boundaries using AI and manual fallback
- [x] Normalize titles, author metadata, and language encoding
- [x] Sanitize raw text and remove formatting artifacts for narration
- [x] Store source format metadata for export integrity
- [x] Enable real-time drag-and-drop multi-book import
- [x] Allow manual override and merge/split of chapter segments
- [x] Integrate OCR scanning for image-based books or comics
- [x] Highlight dialogue vs. narration during parsing
- [x] Auto-tag genre and tone during structural scan
- [x] Support parsing for poetry, stageplay, and hybrid book types
- [x] Save parsed state for recovery and version history
- [x] Embed book-level content warnings and safety tags
- [x] Parse footnotes, indexes, and references for narrator adaptation
- [x] Identify languages used per section and prepare multilingual routing
- [x] Allow preview of parsed structure before committing to render
- [x] Detect pacing shifts (action vs. reflection) in text flow
- [x] Extract scene-based summaries for quick rendering
- [x] Offer import templates for common formats (Kindle, Smashwords, etc.)
- [x] Support 100MB+ file sizes with chunked asynchronous parsing
- [x] Validate file encoding and handle legacy or corrupted files
- [x] Provide parsing logs and error highlighting to the creator

### Phase 2 – Voice Assignment & TTS Logic
- [x] Assign default narrator voice for books with single-voice rendering
- [x] Detect and tag character dialogue blocks for multi-voice casting
- [x] Link recurring character names to voice profiles using memory system
- [x] Enable user-defined cast templates with role-to-voice mapping
- [x] Detect tone of character dialogue (angry, sad, joyful) using emotion AI
- [x] Integrate LocalVoiceAI and ElevenLabs fallback TTS renderers
- [x] Add emotion-to-pitch/pace modulation (e.g., sad = slower, lower)
- [x] Support voice blending for internal monologue vs. external dialogue
- [x] Allow users to test voice preview samples per character before rendering
- [x] Add automatic narrator voice adjustments during high-tension scenes
- [x] Fork voices into alternate variants for multiverse or memory arcs
- [x] Tag first-person vs. third-person POV to determine voice switching
- [x] Support voice regional accents (British, Australian, Indian, etc.)
- [x] Voice delivery pacing optimized for line length and context complexity
- [x] Adjust pause duration between lines based on speaker change
- [x] Integrate pronunciation dictionaries per character for name consistency
- [x] Implement voice style presets: fantasy, sci-fi, horror, romance
- [x] Use AI to recommend voices based on genre and writing style
- [x] Visual cast map UI to display all character-voice assignments
- [x] Real-time rendering monitor to preview TTS results as generated
- [x] Save voice assignments in user profiles for cross-book persistence
- [x] Detect overlapping voices and adjust timing to simulate conversation

### Phase 3 – Immersive Playback & Ambient Systems
- [x] Design ambient FX engine to layer audio environments under narration
- [x] Create FX libraries categorized by genre (forest, city, tavern, spaceship)
- [x] Match ambient background to scene tone and location description
- [x] Add footstep, door, paper, wind, and cloth motion FX by context
- [x] Control ambient volume scaling by scene intensity (whispers vs. battle)
- [x] Implement ambient crossfade logic between chapters and locations
- [x] Use low-frequency rumble or musical drones for tension buildup
- [x] Enable environmental reverb and echo based on scene size (hall vs. closet)
- [x] Layer background conversation FX for crowds or taverns
 - [x] Auto-detect ambient transitions in narration and apply FX changes
- [x] Introduce weather-specific layers (thunder, rain, desert wind)
 - [x] Support 3D spatial panning of sound FX for immersive headset playback
 - [x] Scene FX presets (e.g., "Haunted Mansion", "Rainy Battlefield") with auto-load
- [x] Allow creators to toggle immersive mode on/off per book or chapter
 - [x] Sync ambient playback to narrator pacing and pause intervals
- [x] Design UI switch to mute FX while preserving speech
 - [x] Add sandbox preview of ambient + voice mix per scene
- [x] Generate FX track separately for export as audio stem
- [x] Tag FX layers for accessibility filtering (e.g., no thunder for noise-sensitive)
- [x] Allow user-uploaded FX packs with tagging support
- [x] Record listener reactions to FX scenes for future personalization
- [x] Enable real-time ambient FX updates during streaming TTS playback

### Phase 4 – Long-Term Character Memory & Tone Control
- [x] Establish persistent memory profiles for each major character
- [x] Track voice usage, tone, and traits across multiple books
- [x] Implement character aging logic to evolve voice over time
- [x] Save memory tokens (milestones, trauma, growth) per character
 - [x] Adjust emotional tone delivery based on past scenes (e.g., grief affects voice)
- [x] Support flashback-specific tone adjustments (reverberation, echo)
- [x] Tag emotional arcs and tie them to narrator modulation rules
- [x] Maintain a character timeline of voice intensity and expressiveness
- [x] Apply stress-level voice distortion during arguments or danger
- [x] Create character dossier panel for memory review/editing
- [x] Support "memory lock" to preserve voice consistency despite new scripts
 - [x] Recommend tone variation based on context and prior memory state
 - [x] Integrate cross-book story arc tracking (hero's journey, redemption, fall)
- [x] Detect character reappearances and retrieve voice memory automatically
 - [x] Allow adaptive tone matching when character enters new genres/settings
 - [x] Model relationships: voice modulation changes depending on who is speaking to whom
- [x] Use memory weights to prioritize emotional realism over narration neutrality
- [x] Enable timeline visualization of a character’s voice evolution
 - [x] Cross-link tone history with voice fingerprint DNA across the series
- [x] Support tone comparison mode between books for authorial analysis
- [x] Highlight inconsistencies in voice delivery across books for correction
- [x] Embed character memory files as part of export metadata for continuity

### Phase 5 – Multiverse & Timeline-Aware Audio Narration
- [x] Introduce multiverse tagging for alternate character arcs and scenes
- [x] Fork voice profiles to support divergent personalities per timeline
- [x] Tag chapters with timeline markers (A, B, Prime, Dark, etc.)
- [x] Sync multiverse tags with persistent voice and emotional memory
- [x] Create branching logic visualizer to display multiverse path options
- [x] Enable user selection of which timeline to follow during playback
- [x] Allow creator-defined scene forks with different FX and voice tones
- [x] Track listener path choices and feed into character memory
- [x] Adjust ambient and pacing based on multiverse setting (e.g., dystopia = slower)

- [x] Support "multiverse collapse" audio effect when timelines converge
- [x] Enable alternate endings per timeline with unique tonal conclusions
- [x] Fork narrator tone for speculative/what-if chapters
- [x] Store multiverse path data in playback history and sync across devices
- [x] Integrate "director notes" mode to highlight multiverse scenes
- [x] Allow hidden timeline unlocks based on listener behavior
- [x] Provide multiverse context summaries for catching up mid-path
- [x] Support flashback-within-alternate-timeline scenes
- [x] Build multiverse continuity checker for tone, character, and FX
- [x] Auto-adjust emotion modulation when characters encounter variants of themselves
- [x] Embed multiverse state tags into export files for advanced metadata
- [x] Allow experimental rendering mode with parallel timeline mix
- [x] Allow hidden timeline unlocks based on listener behavior
- [x] Provide multiverse context summaries for catching up mid-path
- [x] Support flashback-within-alternate-timeline scenes
- [x] Build multiverse continuity checker for tone, character, and FX
- [x] Auto-adjust emotion modulation when characters encounter variants of themselves
- [x] Embed multiverse state tags into export files for advanced metadata
- [x] Allow experimental rendering mode with parallel timeline mix

- [x] Enable Creator sandbox to test and preview all forks side-by-side

- [x] Enable export to MP3, WAV, FLAC formats with metadata embedding
- [x] Auto-tag files with narrator, chapter, genre, and FX metadata
- [x] Support segmented export (chapter-by-chapter or full-book)
- [x] Allow users to include/exclude ambient and NSFW layers in export
- [x] Enable fingerprinted voice tagging for IP verification
- [x] Provide real-time export preview and file size estimation
- [x] Build queue manager for batch exporting multiple projects
- [x] Allow creators to export multitrack files (voice, ambient, FX)
- [x] Support export templates (e.g., Audible-ready, Podcast format)
- [x] Compress long-form books into optimal mobile delivery bundles
- [x] Offer download resume support and interruption handling
- [x] Add cross-device sync: track last listened chapter, scene, and timestamp
- [x] Sync memory state and emotional arc history between devices
- [x] Allow per-user customization of export format defaults
- [x] Enable Creator subscription tier detection and permission gating
- [x] Track export credit usage for pay-as-you-go systems
- [x] Offer credit bundles and auto-top-up for high-volume creators
- [x] Show subscription tier benefits in dashboard with upgrade CTA
- [x] Integrate analytics reporting on export/download performance
- [x] Support cloud backup of render states and export templates
- [x] Add DRM toggle for exports requiring usage protection
- [x] Provide offline-friendly audiobook playback format generator

### Phase 7 – NSFW Mode & Advanced Emotional Tuning
- [x] Implement NSFW voice profiles with explicit tone, breathing, and cadence
- [x] Create age-gated toggle for NSFW rendering mode
- [x] Enable character-specific NSFW permission settings
- [x] Tag NSFW scenes in transcript for optional exclusion in export
- [x] Provide tone modulation tools for sensuality, aggression, vulnerability
- [x] Match ambient FX to erotic or horror tones (e.g., bed creaks, moans, echoes)
- [x] Add intensity meter to scale NSFW performance (suggestive → explicit)
- [x] Blend romantic, comedic, and fantasy sub-tones for genre flexibility
- [x] Apply whisper-pass filter for intimacy scene enhancement
- [x] Include pacing sensitivity slider for slow-burn vs rapid tones
- [x] Build preview system for NSFW scenes before full render
- [x] Auto-adjust reverb and spacing to enhance immersive adult scenes
- [x] Allow background FX library upload for adult creators
- [x] Enable dynamic NSFW transitions from safe to explicit based on context
- [x] Respect Creator subscription rules for NSFW access and credits
- [x] Save NSFW usage history to provide tone consistency in future chapters
- [x] Flag NSFW content for internal moderation or publishing filter logic
- [x] Auto-detect safe vs. unsafe content for preview-only versions
- [x] Build Creator dashboard to manage NSFW scene ratings per book
- [x] Simulate body contact dynamics through rhythmic ambient FX cues
- [x] Render alternate PG-13 safe version of same scene for public platforms
- [x] Track listener skip behavior on NSFW scenes for feedback optimization

### Phase 8 – Cross-Book Memory, Language, and Unabridged Logic
- [x] Track character development arcs across multiple books and universes
- [x] Sync voice tone evolution based on previous book outcomes
- [x] Detect and recall key events from prior titles to affect current narration
- [x] Map memory triggers to emotion modulation for recurring themes
- [x] Generate emotional arc summaries for each book and voice profile
- [x] Translate entire books while preserving narrator tone and genre
- [x] Match accents to region and character origin dynamically
- [x] Create multilingual narration with seamless voice switch per language
- [x] Add genre-aware translation modes (e.g., poetic for fantasy, direct for nonfiction)
- [x] Enable narrator tone matching during back-translations (reverse language)
- [x] Preserve paragraph-level pacing in translated output
- [x] Flag idioms and phrases for creative language adaptation
- [x] Allow inline multilingual conversations with character accent routing
- [x] Implement voice glossaries for culturally relevant pronunciation
- [x] Render unabridged books up to 40+ hours without loss of pacing
- [x] Optimize long-form rendering using audio caching checkpoints
- [x] Insert smart bookmarks at scene/act/chapter transitions
- [x] Auto-generate full table of contents with audio-linked sections
- [x] Provide unabridged-to-abridged summarization mode for preview
- [x] Adapt narration style based on genre and reader profile (e.g., thriller vs. memoir)
- [x] Detect formatting features (lists, quotes, poetry) and adjust narration accordingly
- [x] Store memory snapshots between render sessions for persistent output quality

### Phase 9 – Full-Cast Audio Mastering & Creator Intelligence Suite
- [x] Assign separate audio tracks to each character and narrator for post-mix mastering
- [x] Generate multitrack session files for DAWs (e.g., Logic, Pro Tools, Audition)
- [x] Sync ambient layers, voice tracks, and FX on a shared scene timeline
- [x] Enable per-character equalization, pitch adjustment, and compression
- [x] Simulate stereo spatial positioning per voice (left/right, near/far)
- [x] Build emotion intensity heatmap per scene to guide tone balancing
- [x] Create a full-cast preview mode with toggles for each voice track
- [x] Add creator-defined vocal layering for crowd and background dialogue
- [x] Offer toggle for “narrator override” mode for consistency across multi-voice scenes
- [x] Auto-suggest optimal scene pacing based on text intensity and emotion tags
- [x] Detect dialogue overlap potential and adjust timing automatically
- [x] Use AI to recommend narration cadence per genre and reader preference
- [x] Export final audio as flattened or layered file based on creator choice
- [x] Tag character emotional states per segment to match musical score inputs
- [x] Link scene-based voice dynamics to background music templates
- [x] Integrate with audio plugin systems for advanced mastering tools
- [x] Enable Creator AI Assistant to generate scene-specific mastering presets
- [x] Provide auto-mix-and-export mode for rapid prototyping
- [x] Build creator dashboard for real-time monitoring of voice quality and performance
- [x] Visualize voice dominance per chapter using waveform or tone charts
- [x] Offer beta features: audio fingerprints for licensing, alternate casting previews
- [x] AI-based performance coach to recommend enhancements after preview



## CoreForge Audio UI Completion: Feature-Based Expansion
### AI & AUDIO ENGINE FEATURES

- [ ] `VoiceEmotionControlView.swift` – Add tone/emotion picker per character or chapter.
- [ ] `VoiceMemoryView.swift` – Show persistent voice cast history across books.
- [ ] `AmbientFXMixerView.swift` – Visual FX blend control per scene/book.
- [ ] `NSFWToggleView.swift` – Add in-player and global toggle for NSFW mode.
- [ ] `LanguageSelectorView.swift` – UI for per-book/per-chapter language choice.
- [ ] `ExportQueueView.swift` – List view of recent and in-progress exports.

### 🎧 PLAYBACK EXPERIENCE UPGRADES

- [ ] `MiniPlayerView.swift` – Floating player for quick resume.
- [ ] `PlaybackSpeedControlView.swift` – Speed picker (1x–5x).
- [ ] `VoicePickerView.swift` – Dropdown for active narration voice.
- [ ] `SwipePreviewHandler.swift` – Tap-and-hold or swipe to preview voices.
- [ ] `ChapterProgressView.swift` – Visual tiles for in-progress chapters.
- [ ] Add `.matchedGeometryEffect` for MiniPlayer → PlayerView transition.

### 📚 LIBRARY DASHBOARD ENHANCEMENTS

- [ ] `FavoritesCarouselView.swift` – Row for user-tagged favorite books.
- [ ] `ContinueListeningView.swift` – Displays paused books or last 3 played.
- [ ] `RecentlyImportedView.swift` – Latest EPUB/PDF/TXT added to library.
- [ ] `DownloadsManagerView.swift` – Shows offline-only content + space usage.
- [ ] Add sort/filter chips to `SearchView` (Favorites, Downloaded, Unplayed).

### 👤 USER INSIGHTS & PROFILE

- [ ] `ProfileTierCardView.swift` – Shows current plan, upgrade CTA, avatar.
- [ ] `ListeningStatsView.swift` – Listening streaks, hours, completions.
- [ ] Add alert badge if streak is broken or goal achieved.

### 🛡 MONETIZATION & TIER ACCESS

- [ ] `NSFWUnlockModal.swift` – Dialog shown if NSFW add-on not active.
- [ ] `UpgradeBlockOverlay.swift` – Blocks gated features for Free users.
- [ ] `AudioCreditStatusView.swift` – Shows remaining MP3 export credits.
- [ ] `SubscriptionUpgradeView.swift` – Multi-plan selector for Creator/Enterprise.

### 🖌 VISUAL POLISH & RESPONSIVENESS

- [ ] Expand `Theme.swift` – Apply consistent gradient + corner radius + shadows.
- [ ] Apply `.ultraThinMaterial` to all content cards.
- [ ] Add `.transition(.scale)` or `.opacity` to card actions and modals.
- [ ] Audit all UI for dark mode readiness with semantic SwiftUI colors.
- [ ] Add empty state visuals (Library, Stats, Player) using branded illustration.

### 📁 DIRECTORY STRUCTURE EXTENSIONS
```
Views/
├── ContinueListeningView.swift
├── DownloadsManagerView.swift
├── RecentlyImportedView.swift
├── ExportQueueView.swift
├── FavoritesCarouselView.swift
├── LanguageSelectorView.swift
├── VoiceMemoryView.swift
├── VoiceEmotionControlView.swift
├── ListeningStatsView.swift
├── ProfileTierCardView.swift
├── SubscriptionUpgradeView.swift

Components/
├── PlaybackSpeedControlView.swift
├── VoicePickerView.swift
├── NSFWToggleView.swift
├── SwipePreviewHandler.swift
├── NSFWUnlockModal.swift
├── UpgradeBlockOverlay.swift
Theme/
├── Theme.swift
```

---

## ✅ Codex Instruction:
Track and check off each component as it's generated, tested, and added to GitHub `/apps/CoreForgeAudio/Views/` or `/Components/` folder. Ensure all `.swift` files use `#Preview` blocks and follow `Theme.swift` visual conventions.

=======
## CoreForge Audio UI Enhancements

### Dashboard & Library Interface
- [x] `LibraryDashboardView.swift` – Main home screen layout with scrollable sections and mini player.
- [x] `FeaturedCarouselView.swift` – Top swipeable banner for featured content.
- [x] `MiniPlayerView.swift` – Fixed bottom control panel with playback and expand action.

### Search & Discovery
- [x] `SearchView.swift` – Book/author/chapter search with filters and sort options.
- [x] `VoicePreviewPopup.swift` – Tap-and-hold voice preview overlay for characters.

### Profile & Listening Insights
- [x] `ProfileTierCardView.swift` – Displays current plan, avatar, and upgrade button.
- [x] `ListeningStatsView.swift` – Weekly/monthly listening stats and achievements.
- [x] `ChapterProgressView.swift` – Tiles showing current in-progress chapters.

### Playback Extensions
- [x] `PlaybackSpeedControlView.swift` – Allows speed selection and voice swapping.
- [x] Add `matchedGeometryEffect` to MiniPlayer → PlayerView transition.

### Library Enhancements
- [x] Add download indicators to all book cards.
- [x] Add heart/favorite toggle to book items.
- [x] Add "Favorites" section to `LibraryDashboardView`.

### Visual & Theming
- [x] Expand `Theme.swift` – Add gradient, blur, shadows, and standardized styling.
- [x] Apply `ultraThinMaterial` to all cards and overlays.
- [x] Implement light/dark mode compatibility using semantic SwiftUI colors.
- [x] Animate transitions between key views using `.transition` and `.animation`.

### Output File Structure
```
Views/
├── LibraryDashboardView.swift
├── FeaturedCarouselView.swift
├── MiniPlayerView.swift
├── SearchView.swift
├── ListeningStatsView.swift
├── ProfileTierCardView.swift
├── ChapterProgressView.swift
Components/
├── PlaybackSpeedControlView.swift
├── VoicePreviewPopup.swift
Theme/
├── Theme.swift
```


# agents.md — CoreForge App Production Readiness Checklist (All Apps)

## 🎯 Objective:
Ensure that CoreForge Audio, Visual, and Build are 100% functionally complete, stable, and production-ready for App Store, Play Store, and desktop/web deployment.

---

## ✅ Functional Completion

- [ ] All Codex agents, core views, and managers are implemented and verified
- [ ] All planned app features are present and testable
- [ ] Onboarding flow fully functional and launches only once
- [ ] All views support dynamic resizing and device rotation (where applicable)
- [ ] All modules contain full `#Preview` support for SwiftUI

---

## ✅ Navigation & Routing

- [ ] App launches into the correct root view
- [ ] Tab navigation works across all platforms and all tabs retain state
- [ ] Deep linking / modal sheets / view stacks work and return correctly

---

## ✅ UI Consistency & Branding

- [ ] CoreForge theme (`primaryGradient`, `ultraThinMaterial`, `cornerRadius`) applied globally
- [ ] All app icons in `.appiconset` are exported and installed
- [ ] Light/Dark mode support implemented using semantic colors
- [ ] Launch screen matches brand gradient and app name
- [ ] Splash logo displays properly on all platforms

---

## ✅ Feature Stability

- [ ] Playback system works with custom voices and ambient FX (CoreForge Audio)
- [ ] Scene generation renders and exports correctly (CoreForge Visual)
- [ ] Apps generate and export .ipa/.apk/.exe/.dmg correctly (CoreForge Build)
- [ ] NSFW gating logic functions securely and consistently across all platforms
- [ ] Subscription features are unlocked, gated, and revertable correctly
- [ ] Import, export, build, and generate features persist across sessions

---

## ✅ Monetization & Subscriptions

- [ ] All IAP options work (NSFW, export credits, Creator/Enterprise plans)
- [ ] Subscription upgrades properly unlock features
- [ ] Promo codes (e.g., `CREATORACCESS`, `VISIONBETA`) unlock and persist
- [ ] Credit consumption reflects usage in UI (audio, video, app builds)
- [ ] Price tiers and usage logic reflected in `SubscriptionManager.swift`

---

## ✅ User Data & Preferences

- [ ] User preferences stored with `@AppStorage` and load correctly
- [ ] Offline content support in each app (audio, video, app saves)
- [ ] Download manager UI present where needed
- [ ] NSFW preference gated behind user age/plan

---

## ✅ Export & Distribution

- [ ] All export options (audio, video, builds) functional with local save
- [ ] Auto-upload toggles functional and route to correct platforms (Visual only)
- [ ] Local output directory support or Share Sheet UI on mobile

---

## ✅ Developer & GitHub Integration

- [ ] Each app folder includes:
    - `agents.md`
    - `README.md`
    - `baseline_requirements.md`
    - `FEATURES-CODEX-COMPLETE.md`
- [ ] All GitHub secrets and PATs tested and working for CI/CD
- [ ] `.ipa`, `.apk`, `.dmg`, `.exe`, and `web` versions confirmed working and uploaded

---

## ✅ QA Testing + Launch Readiness

- [ ] All modules unit tested
- [ ] All flows tested manually on iOS and Android simulators
- [ ] Zipped bundles for each app uploaded to Google Drive
- [ ] App Store / TestFlight metadata (`AppIcon`, screenshots, description) ready
- [ ] Apps pass Xcode and Android Studio validation

---

## ✅ Final Go-Live

- [ ] GitHub repo tagged as production ready
- [ ] App uploaded to App Store Connect + Play Store internal testing
- [ ] Announce launch with press kit + onboarding video

