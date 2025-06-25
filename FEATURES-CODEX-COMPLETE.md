# 📘 FEATURES-CODEX-COMPLETE.md
### App: CoreForge Visual
**Tiers**: `Free`, `Pro`, `Creator`
**Tags**: `NSFW`, `Offline`, `BookToVideo`, `Multiverse`, `AI Rendering`, `VoiceSync`
**Last Updated**: 2025-06-22

---

## ✅ Phase 1 – Scene Import & Breakdown (Free Tier)

### 📚 Book Import & Scene Parser
- [x] `BookImporter.import(file): Promise<Scene[]>`
- [x] Parse EPUB/PDF/TXT into story blocks
- [x] Extract visual scene descriptors and dialogue
- [x] Normalize chapters into visual sequences

### 🧠 Scene Detector
- [x] `SceneDetector.analyze(text): SceneMap`
- [x] Detect scene shifts via NLP (e.g., time jump, location change)
- [x] Tag scenes with estimated tone, setting, pacing
- [x] Save scene structure in persistent format

---

## ✅ Phase 2 – Character & Scene Builder (Pro Tier)

### 🎭 Character Identity Mapping
- [x] Match characters with avatar templates
- [x] Assign age, gender, personality traits
 - [x] Support facial expression presets (happy, angry, neutral)
 - [x] Auto-suggest avatars by genre

### 🏗️ Scene Builder
- [x] `SceneBuilder.build(scene: Scene): RenderConfig`
- [x] Match character(s), setting, props
- [x] Annotate shot list (close-up, wide, over-shoulder)
- [x] Inject emotion or FX tags into each shot

---

## ✅ Phase 3 – Visual Generator & Renderer (Pro+ Tier)

### 🎞️ AI Video Generator
- [x] `VisualRenderer.render(config: RenderConfig): VideoClip`
- [x] Generate video from prompt + voice + ambient FX
- [x] Integrate with external or local video model
- [x] Allow rendering style: anime, fantasy, live-action, etc.

### 🌠 FX Layer System
- [x] Add scene-level visual effects (fog, sparks, neon glow)
- [x] Overlay genre-specific filters
- [x] Allow real-time FX preview

### 🎙 Voice-to-Video Sync
- [x] Sync facial movement and scene cuts to speech timing
- [x] Support pre-recorded and generated voice tracks
- [x] Allow lip-sync toggle for faster rendering

---

## ✅ Phase 4 – Adaptive Logic & Memory (Creator Tier)

### 🧠 Visual Memory Engine
- [x] Store character appearances across books
- [x] Preserve visual continuity in sequels
- [x] Handle outfit/age/mood consistency dynamically

### 🧬 Scene DNA Tracker
- [x] Track changes to scenes (e.g., visual DNA fork)
- [x] Let creators “lock” scene visuals for canon
- [x] Link scene DNA to multiverse system

---

## ✅ Phase 5 – Multiverse Tools (Creator Tier)

### 🕸 Multiverse Timeline Manager
- [x] Display alternate visual paths for the same book
- [x] Allow creators to preview multiple visual outcomes
- [x] Tag scene outcomes with timeline markers

### 📊 Scene Branching & Recall
- [x] Store viewer path history (timeline A/B/C)
- [x] Replay scenes with alternate visuals
- [x] Adjust future render suggestions based on prior paths

---

## ✅ Phase 6 – Monetization & Subscription (All Tiers)

### 💵 Credit Engine
- [x] Allow 1 book-to-video conversion per month (Pro)
- [x] Allow 3 books/month for Creator Tier
- [x] Sell extra video credits for $79.99 each

### 🔓 Unlocks & Add-ons
- [x] Auto-upload unlock for $24.99 (2 platforms)
- [x] NSFW unlock ($25/month or bundle $60/all apps)
- [x] Creator tab unlocked via promo code

---

## ✅ Phase 7 – NSFW + Experimental Visual Modes (18+ Creator Tier)

### 🔞 NSFW Visual Mode
- [x] Toggle for erotic/fantasy/surreal scenes
- [x] Hide NSFW previews unless verified
- [x] Censor layer options for safe version rendering

### 🧪 Experimental FX
- [x] Scene fusion mode (blended timelines)
- [x] Hallucinogenic visual filters
- [x] Realistic surrealism toggle (dream logic effects)

---

## ✅ Phase 8 – Compliance, Exports & UI Polish

### 📱 Export Manager
- [x] Export full video to device (MP4)
- [x] Auto-generate thumbnails and cover art
- [x] Add platform-ready metadata

### 📤 Platform Upload Tools
- [x] Upload 1 platform/channel by default
- [x] Add-on unlock for second channel/platform
- [x] Show upload status and logs in dashboard

### ⚙️ Settings Panel
- [x] Style picker (anime, noir, fantasy, etc.)
 - [x] NSFW mode toggle (off by default)
 - [x] Developer console toggle (Creator tier)

---

# ✅ Codex Notes

- Each `[ ]` is a Codex-valid task.
- Use `~` or `x` markers to show progress.
- NSFW + Creator flags guide conditional inclusion.
- Codex should match UI features to logic endpoints.
