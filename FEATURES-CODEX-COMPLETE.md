# 📘 FEATURES-CODEX-COMPLETE.md
### App: CoreForge Visual
**Tiers**: `Free`, `Pro`, `Creator`
**Tags**: `NSFW`, `Offline`, `BookToVideo`, `Multiverse`, `AI Rendering`, `VoiceSync`
**Last Updated**: 2025-06-22

---

## ✅ Phase 1 – Scene Import & Breakdown (Free Tier)

### 📚 Book Import & Scene Parser
- [ ] `BookImporter.import(file): Promise<Scene[]>`
- [ ] Parse EPUB/PDF/TXT into story blocks
- [ ] Extract visual scene descriptors and dialogue
- [ ] Normalize chapters into visual sequences

### 🧠 Scene Detector
- [ ] `SceneDetector.analyze(text): SceneMap`
- [ ] Detect scene shifts via NLP (e.g., time jump, location change)
- [ ] Tag scenes with estimated tone, setting, pacing
- [ ] Save scene structure in persistent format

---

## ✅ Phase 2 – Character & Scene Builder (Pro Tier)

### 🎭 Character Identity Mapping
- [ ] Match characters with avatar templates
- [ ] Assign age, gender, personality traits
- [ ] Support facial expression presets (happy, angry, neutral)
- [ ] Auto-suggest avatars by genre

### 🏗️ Scene Builder
- [ ] `SceneBuilder.build(scene: Scene): RenderConfig`
- [ ] Match character(s), setting, props
- [ ] Annotate shot list (close-up, wide, over-shoulder)
- [ ] Inject emotion or FX tags into each shot

---

## ✅ Phase 3 – Visual Generator & Renderer (Pro+ Tier)

### 🎞️ AI Video Generator
- [ ] `VisualRenderer.render(config: RenderConfig): VideoClip`
- [ ] Generate video from prompt + voice + ambient FX
- [ ] Integrate with external or local video model
- [ ] Allow rendering style: anime, fantasy, live-action, etc.

### 🌠 FX Layer System
- [ ] Add scene-level visual effects (fog, sparks, neon glow)
- [ ] Overlay genre-specific filters
- [ ] Allow real-time FX preview

### 🎙 Voice-to-Video Sync
- [ ] Sync facial movement and scene cuts to speech timing
- [ ] Support pre-recorded and generated voice tracks
- [ ] Allow lip-sync toggle for faster rendering

---

## ✅ Phase 4 – Adaptive Logic & Memory (Creator Tier)

### 🧠 Visual Memory Engine
- [ ] Store character appearances across books
- [ ] Preserve visual continuity in sequels
- [ ] Handle outfit/age/mood consistency dynamically

### 🧬 Scene DNA Tracker
- [ ] Track changes to scenes (e.g., visual DNA fork)
- [ ] Let creators “lock” scene visuals for canon
- [ ] Link scene DNA to multiverse system

---

## ✅ Phase 5 – Multiverse Tools (Creator Tier)

### 🕸 Multiverse Timeline Manager
- [ ] Display alternate visual paths for the same book
- [ ] Allow creators to preview multiple visual outcomes
- [ ] Tag scene outcomes with timeline markers

### 📊 Scene Branching & Recall
- [ ] Store viewer path history (timeline A/B/C)
- [ ] Replay scenes with alternate visuals
- [ ] Adjust future render suggestions based on prior paths

---

## ✅ Phase 6 – Monetization & Subscription (All Tiers)

### 💵 Credit Engine
- [ ] Allow 1 book-to-video conversion per month (Pro)
- [ ] Allow 3 books/month for Creator Tier
- [ ] Sell extra video credits for $79.99 each

### 🔓 Unlocks & Add-ons
- [ ] Auto-upload unlock for $24.99 (2 platforms)
- [ ] NSFW unlock ($25/month or bundle $60/all apps)
- [ ] Creator tab unlocked via promo code

---

## ✅ Phase 7 – NSFW + Experimental Visual Modes (18+ Creator Tier)

### 🔞 NSFW Visual Mode
- [ ] Toggle for erotic/fantasy/surreal scenes
- [ ] Hide NSFW previews unless verified
- [ ] Censor layer options for safe version rendering

### 🧪 Experimental FX
- [ ] Scene fusion mode (blended timelines)
- [ ] Hallucinogenic visual filters
- [ ] Realistic surrealism toggle (dream logic effects)

---

## ✅ Phase 8 – Compliance, Exports & UI Polish

### 📱 Export Manager
- [ ] Export full video to device (MP4)
- [ ] Auto-generate thumbnails and cover art
- [ ] Add platform-ready metadata

### 📤 Platform Upload Tools
- [ ] Upload 1 platform/channel by default
- [ ] Add-on unlock for second channel/platform
- [ ] Show upload status and logs in dashboard

### ⚙️ Settings Panel
- [ ] Style picker (anime, noir, fantasy, etc.)
- [ ] NSFW mode toggle (off by default)
- [ ] Developer console toggle (Creator tier)

---

# ✅ Codex Notes

- Each `[ ]` is a Codex-valid task.
- Use `~` or `x` markers to show progress.
- NSFW + Creator flags guide conditional inclusion.
- Codex should match UI features to logic endpoints.
