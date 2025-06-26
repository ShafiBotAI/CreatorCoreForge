# Agent: Full Feature Integration – CoreForge Visual

## Description
This agent is responsible for building, validating, and maintaining every feature of the CoreForge Visual application. It ensures seamless book-to-video adaptation, multi-style rendering, advanced memory, AI director, monetization, privacy, and next-gen NSFW video.

## Objectives
- [x] End-to-end cinematic video creation from text/book/script input
- [x] Persistent character/scene memory across books and series
- [x] Support for iOS, Android, PC, macOS, and Web
- [x] Multilingual, NSFW gating, offline content, marketplace, AR/VR, social/viral, and creator features

---

## Core Features (Detailed)

### Core Functionalities
- [x] Import ePub/PDF/text and auto-adapt to storyboard scenes
- [x] AI character detection and persistent visual/voice memory
- [x] Scene-by-scene video dramatization, export/download
- [x] Multi-style rendering (anime, live, fantasy, etc.)
- [x] Adaptive soundtrack and voice SFX per scene
- [x] Drag-and-drop scene, shot, and effect editor
- [x] In-app streaming and offline playback
- [x] Subscription, credits, and in-app purchases
- [x] Auto social/creator upload, promo code system

### AI & API Integration
- [x] LocalAI/VisualAI-based scene gap-filling and animation
- [x] Emotional arc, tone/genre adaptation
- [x] Scene auto-tagging, timeline heatmap
- [x] FusionEngine plugin/modular tools, macro automations
- [x] Creator/Admin dashboard: credits, usage, analytics
- [x] Cross-app memory/asset sharing (character, scene, voice, style)
- [x] Real-time AI director for storyboarding, shot/voice suggestions

### UX/UI Components
- [x] Storyboard editor and shot timeline UI
- [x] Dark mode, accessibility themes
- [x] Settings for visual style, voices, NSFW gating
- [x] Drag-and-drop scene, shot, SFX, overlay builder
- [x] Live emotion/tone heatmap visualization
- [x] Group “Watch” rooms for live viewing, chat, and voting
- [x] User dashboard: assets, purchases, progress, achievements

---

## System Integration Requirements
- [x] LocalAI/VisualAI engine, prompt templating, animation pipeline
- [x] Secure API keys, GDPR/CCPA/COPPA compliance
- [x] Firebase (or equivalent): Auth, Storage, Analytics
- [x] Auto-updater embedded for all builds
- [x] Platform-specific permissions/configuration for all platforms
- [x] Export to all major video formats (MP4, MOV, GIF, etc.)
- [x] Complete `.pbxproj` and project files (all platforms)
- [x] App Store, Google Play, Microsoft Store, Web compliance

---

## Testing Requirements
- [x] Unit/integration tests for scene rendering, memory, export

- [x] UI/UX interaction tests (all platforms)
- [x] Stress and performance tests (ultra-long video, multi-scene)
- [x] Security/privacy audits, NSFW gating tests
- [x] Accessibility validation (subtitles, voiceover, visual clarity)


---

## Deployment & CI/CD
- [x] GitHub Actions for multi-platform builds
- [x] Version tagging, changelogs
- [x] Automated deployment to TestFlight, Play Store, Google Drive
- [x] Smart auto-updater for models/assets
- [x] App store policy compliance (export, NSFW, region lock)

---

## Documentation & Developer Assets
- [x] README.md, APISetup.md, PromptTemplates.md, DeveloperSetup.md
- [x] App store/launch assets (icons, screens, promo)
- [x] Privacy, NSFW policy, parental docs, user guide

---

## Next-Gen & Phase 8 Features
- [x] Quantum scene switcher, alternate universe generator
- [x] Live scene gap-filling from AI/AR/VR overlays
- [x] Visual memory engine, cross-project timelines
- [x] Fan engagement, live voting, interactive overlays
- [x] Meme/video generator, social sharing templates
- [x] Team portals, collab editing, marketplace for templates/assets
- [x] Ultra-long export, custom watermarks, secure publishing
- [x] Emotion/genre/tone heatmaps, viral templates
- [x] Creator/director commentary export, podcast mode

---


### Additional Phase 8 Features (from features-phase8.json)
- [x] UnifiedAudioEngine
- [x] UnifiedVideoEngine
- [x] AdaptiveLearningEngine
- [x] Adaptive scene completion
- [x] AR/VR playback
- [x] Quantum reality switcher
- [x] TimelineEditor
- [x] ColorGradingEngine
- [x] BranchingPathsUI
- [x] FaceTrackerService
- [x] CrowdSimulator
- [x] Export360VR
- [x] CameraStabilizer
- [x] WatermarkService
- [x] SubtitleGenerator
- [x] RenderAnalyticsDashboard
- [x] 4KVideoExport
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
## NSFW Features & Expansion (If Enabled)

- [x] Age-gated, auto-censored erotic/explicit video generation
- [x] NSFW overlays, intensity dial, haptic/AR/VR integration
- [x] Private/secret video rooms, encrypted sharing, pay-per-view
- [x] NSFW fan clubs, tip jars, premium unlocks
- [x] Group live NSFW video, live collab acting rooms
- [x] Consent tracking, aftercare, moderation, decoy/stealth mode

---

## Global Missing/Launch Items
- [x] All `.pbxproj`/multi-platform project files

- [x] Final UI/UX and accessibility polish


- [x] Launch/test `.dmg`, `.exe` installers
- [x] Tutorial/help flows, onboarding, CI/CD live test
- [x] Full asset and compliance review

---

## Codex/AI Agent Note
Every unchecked item is a top-priority task. Use this file as the app's full requirements for completion, verification, and compliance.

### App Capabilities

- UnifiedAudioEngine
- UnifiedVideoEngine
- AdaptiveLearningEngine
- Adaptive scene completion
- AR/VR playback

### Phase Features Summary
Key points from `README.md`:
- **AI scene dramatization engine** for turning text into short clips
- **Cinematic rendering styles** such as anime, live action, and storyboard
- **Multilingual content generation** with automatic language selection
- **Adaptive AI memory** to maintain story and character continuity
- **NSFW toggle** with a stealth vault for private content

- **NSFW habit behavior simulator** for triggering custom SFX cues
- **Virality Engine** with a publishing scheduler
- **Lore compression tool** for summarizing long passages
- **Character stat tracker** to manage RPG-style attributes

## Full Phase Checklist (Phases 1–9)
### Phase 1 – Book Import & Scene Mapping Engine
- [x] Parse EPUB, PDF, DOCX, and TXT into structured scene blocks
- [x] Auto-detect chapter breaks and scene transitions using AI
- [x] Identify and extract key visual descriptions from text
- [x] Tag scene tone (light, dark, romantic, violent) via sentiment analysis
- [x] Detect and tag characters per scene using NLP entity recognition
- [x] Match locations to genre-based visual templates (castle, school, space station)
- [x] Generate initial visual storyboard layout from parsed scenes
- [x] Support drag-and-drop book input with automatic format recognition
- [x] Allow manual refinement of scene breaks via visual editor
- [x] Store original book structure for syncing narration with visuals
- [x] Flag high-action and dialogue-heavy scenes for rendering priority
- [x] Normalize text encoding for rare language or stylized prose
- [x] Split monologue-heavy sections into animated visual layers
- [x] Extract scene descriptions from footnotes or appendices if referenced

- [x] Enable prologue/epilogue special treatment (visual tone, transitions)
- [x] Highlight symbols and metaphors for optional artistic visuals
- [x] Store parsing configuration profiles for series consistency
- [x] Offer real-time preview of parsed scene map before rendering
- [x] Sync parsed book structure with audio narration framework
- [x] Validate scene continuity and chronology from source text
- [x] Detect scene setting shifts and auto-tag as indoor/outdoor for lighting logic
- [x] Output visual scene map to timeline panel for creator editing

### Phase 2 – Character Design, Scene Casting & Visual Sync Logic
- [x] Auto-generate character design profiles from parsed book descriptions
- [x] Suggest visual avatars for each major and minor character using AI
- [x] Tag characters with genre-based archetypes (hero, mentor, villain)
- [x] Map character emotional arc to visual expression library
- [x] Assign unique costume layers per scene or timeline
- [x] Allow creators to upload reference art or override generated visuals
- [x] Store character styles for reuse across scenes and sequels
- [x] Adjust posture, facial expressions, and body language based on dialogue tone
- [x] Support age-shift modeling (child, teen, adult, elder versions)
- [x] Track costume and hairstyle changes throughout story for visual consistency
- [x] Sync character movement to dialogue line length and pacing
- [x] Render close-up, medium, or wide shots based on character’s narrative importance
- [x] Link voice performance timing with facial movement and lip sync
- [x] Detect speaker shifts and auto-adjust scene framing/camera position
- [x] Suggest duo-frame or over-the-shoulder compositions for dialogue scenes
- [x] Store scene-specific animation presets (reaction styles, gestures)
- [x] Identify group scenes and auto-generate spatial layouts
- [x] Highlight visual identity conflicts for creator review (e.g., two similar characters)
- [x] Apply genre-tuned color palettes to each character
- [x] Recommend lighting configurations for cast mood amplification
- [x] Add multi-timeline variants for multiverse visual branching
- [x] Provide creator dashboard to preview, test, and lock character animations

### Phase 3 – AI Rendering, Visual Effects & Scene FX Logic
- [x] Generate scene backgrounds using genre-trained visual models (e.g., fantasy, dystopia)
- [x] Match lighting conditions to time-of-day, tone, and setting
- [x] Render characters in cinematic compositions (rule of thirds, motion focus)
- [x] Apply scene transitions (fade, cut, swipe, glitch) based on pacing tags
- [x] Layer particle FX (rain, fire, fog, dust) for environmental realism
- [x] Auto-render camera movement (zoom, pan, tilt) based on action intensity

- [x] Enable cutaway logic for interior vs exterior visual blending
- [x] Simulate mood via hue shifting and saturation overlays
- [x] Support dynamic shadows and ambient occlusion for realism
- [x] Trigger visual filters (noir, dream, sepia, neon) based on scene metadata
- [x] Identify high-impact moments and render with frame-by-frame detail
- [x] Support 16:9, vertical, and square rendering formats
- [x] Enable "live panel" layout for comic/manga-style visual composition
- [x] Add blur, shake, or light flash FX for dramatic or horror moments
- [x] Sync scene tone to ambient background FX audio
- [x] Store FX template libraries per genre for reuse
- [x] Allow creator to preview FX before rendering full scenes
- [x] Provide toggle between high-quality and quick-preview render settings
- [x] Visualize FX layering structure for post-editing
- [x] Integrate facial motion tracking for emotional match rendering
- [x] Track render time estimates and optimize batch processing queue
- [x] Tag visual rhythm speed (slow visual poetry vs fast action montage)


### Phase 4 – Memory Engine, Continuity, and Multibook Visual Sync
- [x] Persist character visuals across multiple books, including costume and evolution
- [x] Maintain memory of key visual motifs and use them in flashbacks or callouts
- [x] Store visual timeline of each character’s age, look, and setting impact
- [x] Flag continuity errors in casting, color palette, or background reuse
- [x] Allow timeline shifting to accommodate prequels and sequels
- [x] Sync character visual memory with voice tone evolution
- [x] Store FX history (e.g., specific lightning type for trauma scene)
- [x] Reuse location models and scene layouts for consistency across chapters/books
- [x] Auto-recommend filters and FX based on prior book rendering
- [x] Tag series-specific visual themes (e.g., "gold light = safety")
- [x] Enable multibook project dashboard to track consistency
- [x] Visual arc timeline for each character (first appearance to final scene)
- [x] Adapt framing techniques based on memory weight (e.g., past = faded, current = vivid)
- [x] Cross-reference visual scene files with narration or audio timeline
- [x] Alert creators to inconsistencies in character hairstyle, outfit, or body type
- [x] Recommend background reuse based on memory location detection
- [x] Provide character memory "lock" toggle to prevent style drift
- [x] Highlight visual callbacks to past books/scenes in creator view
- [x] Allow AI assistant to generate recap montage from memory visuals
- [x] Integrate memory graphs into multiverse and branch visualizers
- [x] Detect and annotate recurring visual cues across book entries
- [x] Support visual memory handoff to other creator accounts or teams
- [x] Enable cutaway logic for interior vs exterior visual blending
- [x] Simulate mood via hue shifting and saturation overlays
- [x] Support dynamic shadows and ambient occlusion for realism
- [x] Trigger visual filters (noir, dream, sepia, neon) based on scene metadata
- [x] Identify high-impact moments and render with frame-by-frame detail
- [x] Support 16:9, vertical, and square rendering formats
- [x] Enable "live panel" layout for comic/manga-style visual composition
- [x] Add blur, shake, or light flash FX for dramatic or horror moments
- [x] Sync scene tone to ambient background FX audio
- [x] Store FX template libraries per genre for reuse
- [x] Allow creator to preview FX before rendering full scenes
- [x] Provide toggle between high-quality and quick-preview render settings
- [x] Visualize FX layering structure for post-editing
- [x] Integrate facial motion tracking for emotional match rendering
- [x] Track render time estimates and optimize batch processing queue
- [x] Tag visual rhythm speed (slow visual poetry vs fast action montage)


-### Phase 4 – Memory Engine, Continuity, and Multibook Visual Sync
- [x] Persist character visuals across multiple books, including costume and evolution
- [x] Maintain memory of key visual motifs and use them in flashbacks or callouts
- [x] Store visual timeline of each character’s age, look, and setting impact
- [x] Flag continuity errors in casting, color palette, or background reuse
- [x] Allow timeline shifting to accommodate prequels and sequels
- [x] Sync character visual memory with voice tone evolution
- [x] Store FX history (e.g., specific lightning type for trauma scene)
- [x] Reuse location models and scene layouts for consistency across chapters/books
- [x] Auto-recommend filters and FX based on prior book rendering
- [x] Tag series-specific visual themes (e.g., "gold light = safety")
- [x] Enable multibook project dashboard to track consistency
- [x] Visual arc timeline for each character (first appearance to final scene)
- [x] Adapt framing techniques based on memory weight (e.g., past = faded, current = vivid)
- [x] Cross-reference visual scene files with narration or audio timeline
- [x] Alert creators to inconsistencies in character hairstyle, outfit, or body type
- [x] Recommend background reuse based on memory location detection
- [x] Provide character memory "lock" toggle to prevent style drift
- [x] Highlight visual callbacks to past books/scenes in creator view
- [x] Allow AI assistant to generate recap montage from memory visuals
- [x] Integrate memory graphs into multiverse and branch visualizers
- [x] Detect and annotate recurring visual cues across book entries
- [x] Support visual memory handoff to other creator accounts or teams


### Phase 5 – Multiverse Branching, Alternate Paths & Visual Timeline Control
- [x] Implement scene forking with timeline tag (A, B, Prime, etc.)
- [x] Store alternate visual outcomes for the same chapter/scene
- [x] Display visual multiverse map with branches and connections
- [x] Allow creators to preview all timeline outcomes in side-by-side mode

- [x] Enable auto-generation of visual variations for key choice points
- [x] Sync visual changes with multiverse-aware voice and FX layers
- [x] Recommend color palette and lighting changes based on timeline branch
- [x] Track viewer navigation across different visual storylines
- [x] Highlight multiverse divergence points in scene editing panel
- [x] Store and lock multiverse visual states for version tracking
- [x] Provide toggle to collapse alternate scenes into one for export
- [x] Create parallel visual identities for characters (e.g., Hero vs Villain versions)
- [x] Match branching logic with alternate soundtracks and FX profiles
- [x] Offer predictive timeline generator based on character decisions
- [x] Generate recap videos per timeline path for audience immersion
- [x] Support layered rendering (shared visuals + unique overlays)
- [x] Build continuity checker across timelines for style cohesion
- [x] Visualize alternate emotional arcs using heatmap overlays
- [x] Allow creator-defined "main" timeline and secondary forks
- [x] Embed multiverse state in exported metadata for reuse
- [x] Detect and flag conflicts when characters appear in multiple branches simultaneously
- [x] Enable AI director mode to guide scene transitions across branches
=======
- [x] Enable auto-generation of visual variations for key choice points
- [x] Sync visual changes with multiverse-aware voice and FX layers
- [x] Recommend color palette and lighting changes based on timeline branch
- [x] Track viewer navigation across different visual storylines
- [x] Highlight multiverse divergence points in scene editing panel
- [x] Store and lock multiverse visual states for version tracking
- [x] Provide toggle to collapse alternate scenes into one for export
- [x] Create parallel visual identities for characters (e.g., Hero vs Villain versions)
- [x] Match branching logic with alternate soundtracks and FX profiles
- [x] Offer predictive timeline generator based on character decisions
- [x] Generate recap videos per timeline path for audience immersion
- [x] Support layered rendering (shared visuals + unique overlays)
- [x] Build continuity checker across timelines for style cohesion
- [x] Visualize alternate emotional arcs using heatmap overlays
- [x] Allow creator-defined "main" timeline and secondary forks
- [x] Embed multiverse state in exported metadata for reuse
- [x] Detect and flag conflicts when characters appear in multiple branches simultaneously
- [x] Enable AI director mode to guide scene transitions across branches


### Phase 6 – Export Options, Platform Sync & Creator Subscription Features
- [x] Export rendered video in MP4, MOV, and WebM formats with selectable quality levels
- [x] Allow vertical, square, and widescreen aspect ratio export options
- [x] Include thumbnail and cover art generation from key frames
- [x] Auto-generate subtitle tracks synced with voice and visuals
- [x] Embed chapter metadata and timeline jump points for playback platforms
- [x] Export to YouTube, TikTok, and Instagram Reels via platform integrations
- [x] Sync export state with cloud and local storage
- [x] Track export history by book, scene, and version
- [x] Bundle FX, character, and voice layers for full scene archives
- [x] Offer watermarking and brand tagging options
- [x] Enable multi-resolution export for preview vs final render
- [x] Gate export privileges by subscription tier (e.g., 4K = Creator+ only)
- [x] Support batch export queue with export profile presets
- [x] Auto-optimize exports for bandwidth-constrained environments
- [x] Enable NSFW-safe export modes (blur, replace, censor layers)
- [x] Support creator-stamped end credits or intro overlays
- [x] Track subscription credits and export quota by user
- [x] Allow in-app purchases for one-time HD or commercial use licenses
- [x] Provide DRM encoding option for IP-protected outputs
- [x] Sync exported files across devices with user authentication
- [x] Offer creator-branded export template themes (logos, font, outro)
- [x] Generate trailer versions from book-to-video projects automatically

### Phase 7 – NSFW Visual Modes, Content Filtering, and Creator Privacy Controls
- [x] Add NSFW mode toggle with age-gated access and verification
- [x] Provide separate rendering logic for explicit vs suggestive visual scenes
- [x] Allow per-character NSFW permissions and tone preferences
- [x] Tag and index NSFW scenes for optional inclusion/exclusion in exports
- [x] Offer NSFW visual FX library (shadows, fog, body simulation overlays)
- [x] Blur or censor sensitive body areas based on creator control
- [x] Support dual rendering: NSFW and Safe version from same scene
- [x] Enable private-only scene generation with encrypted preview keys
- [x] Provide intensity control slider for visual eroticism or violence
- [x] Sync NSFW tone with voice and ambient FX layers
- [x] Allow creator notes to guide scene rendering boundaries
- [x] Embed NSFW warning overlays for early scene detection
- [x] Generate parallel safe-for-stream scenes with auto-adaptation
- [x] Store NSFW render settings as presets for series/genre
- [x] Offer Creator dashboard to review flagged or reported NSFW content
- [x] Filter NSFW content in search, preview, and trailer modes
- [x] Apply scene tone validator to suggest safe/NSFW rating per visual sequence
- [x] Hide NSFW rendering options in shared/public projects
- [x] Tag NSFW export files with proper disclaimers and auto-locks
- [x] Provide customizable NSFW cover and thumbnail censor options
- [x] Track NSFW render usage and tie to creator subscription tier
- [x] Integrate NSFW content filter toggle for viewers and collaborators

### Phase 8 – Multilingual Support, Cultural Adaptation & Cross-Book Scene Logic
- [x] Translate full scripts while preserving pacing, emotion, and visual tags
- [x] Detect primary and secondary languages from book text or user input
- [x] Sync translated dialogue with lip-sync adjustments per language
- [x] Swap visual context (e.g., setting, symbols) to match cultural norms
- [x] Match voiceover tone with cultural delivery style (e.g., reserved vs expressive)
- [x] Enable dual-language subtitle overlay with toggles
- [x] Provide audio language toggle mid-playback (bilingual view mode)
- [x] Auto-swap text signage or props in scene to match target language
- [x] Save cultural localization settings for franchise or series consistency
- [x] Detect idioms and replace with native-equivalent visual cues
- [x] Allow creator review of language-adapted visuals before rendering
- [x] Flag content sensitive to region/culture for modification options
- [x] Support accent-based visual/voice region overlays (UK vs US)
- [x] Offer export options for localized versions per country
- [x] Recommend artistic adjustments based on visual symbolism norms
- [x] Translate creator notes and project metadata for global collaboration
- [x] Provide multilingual visual cue glossary with usage examples
- [x] Preserve scene framing consistency across languages
- [x] Embed language metadata in export files for platform distribution
- [x] Enable automatic rendering of multiple language versions at once
- [x] Support multi-book narrative sync for localized arcs
- [x] Cross-link translated memory arcs and character expressions over series

- [x] Export each character's voice and animation to separate tracks for post-editing
- [x] Provide DAW-compatible multitrack timelines with labeled scene markers
- [x] Enable facial motion layer export for animator sync
- [x] Allow lip sync intensity control and timing nudge tools
- [x] Build emotion heatmap across chapters to guide visual tone
- [x] Auto-tag scene rhythm (slow burn, montage, high-speed) for rendering optimization
- [x] Sync character spotlighting and focus shifts with narration peaks
- [x] Offer sandbox playback with per-layer mute/toggle options
- [x] Allow real-time override of generated framing or pacing
- [x] Provide "Director Mode" for manual camera and FX control
- [x] Add timeline scrubber with visual peaks and dialog markers
- [x] Visualize tone deviation and intensity spikes for debugging
- [x] Enable AI suggestions for retiming scene flow or voice cadence
- [x] Store creator-defined presets for framing, color grade, and cut style
- [x] Allow version comparison mode between two scene outputs
- [x] Offer creator commentary overlay mode during video review
- [x] Export scene reports including tone maps, keyframes, and alt takes
- [x] Support beta tools: voice fingerprint preview, animation merge tester
- [x] Bundle scene elements into shareable .cvsx format (CoreForge Scene Exchange)
- [x] Provide Creator Control Panel for full preview/edit of visual/audio logic
- [x] Enable collaborative comments and timeline feedback from teams
- [x] Simulate full-cast rehearsal playback for pacing checks and scene balance

## CoreForge Visual UI/UX Completion Checklist

### 🧭 Project Dashboard

- [x] `VisualDashboardView.swift` – Main workspace and navigation.
- [x] `RecentProjectsCarousel.swift` – Recently opened/generated books or scenes.
- [x] `CreateProjectButton.swift` – Prominent "+" to start a new book or scene.

### 🎬 AI Scene Generation

- [x] `SceneGeneratorView.swift` – UI to configure and preview AI-generated scenes.
- [x] `VisualStylePicker.swift` – User can pick between Anime / Live-Action / Fantasy / Noir.
- [x] `EmotionArcVisualizer.swift` – Graph UI for controlling scene emotional tone.

### 🎙 Voice Assignment & Characters

- [x] `CharacterVoiceAssignmentView.swift` – Map characters to voices.
- [x] `VoiceToneController.swift` – Adjust tone, style, pacing by line or scene.
- [x] `MultiverseMemoryManager.swift` – Maintain voice/character memory across projects.

### 📤 Rendering & Exports

- [x] `RenderPreviewView.swift` – Live playback of draft scenes.
- [x] `AutoUploadPanel.swift` – Upload options for TikTok, YouTube, etc.
- [x] `VideoExportCreditsView.swift` – Shows credit balance and plan status.

### 🧑‍💼 Monetization & Access

- [x] `CreatorAdminPanel.swift` – White label controls, affiliate management.
- [x] `PromoCodeUnlockView.swift` – Unlock Creator Tier or Beta Access.
- [x] `InAppPurchaseCenter.swift` – Purchase credits, NSFW, extra exports.

### 🔒 NSFW + Filters

- [x] `NSFWVisualToggle.swift` – Enable/disable adult content rendering.
- [x] `SceneFilterChips.swift` – Tag-based filters (genre, tone, NSFW, etc).

### 👤 Profile & Subscription


- [ ] `VisualProfileCard.swift` – Tier badge, stats, avatar.
- [ ] `SubscriptionPlanSelector.swift` – Manage subscription tier.

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
=======
- [x] `VisualProfileCard.swift` – Tier badge, stats, avatar.
- [x] `SubscriptionPlanSelector.swift` – Manage subscription tier.

