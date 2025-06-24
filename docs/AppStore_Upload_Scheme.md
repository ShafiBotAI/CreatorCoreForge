# App Store Upload Scheme – CoreForge App Suite

This document outlines the packaging, signing, and deployment scheme for each CoreForge app on both Apple App Store and Google Play.

---

## Shared Requirements (All Apps)

- Bundle ID format: `com.coreforge.[appname]`
- Use Apple Developer account (Team ID required)
- Upload via Xcode or Transporter (iOS/macOS) and Google Play Console (Android)
- Include:
  - App icon (1024x1024 PNG, no transparency)
  - Launch screen and splash images
  - App Store description, keywords, and age rating
  - Privacy Policy, Terms of Service, and contact email
  - Screenshot sets (iPhone, iPad, Android phones/tablets)

---

## CoreForge Audio
- Bundle ID: `com.coreforge.audio`
- Target Platforms: iOS, Android, macOS
- Exported as: `.ipa`, `.apk`, `.dmg`
- Required Permissions: microphone, local file storage
- App Store Notes: NSFW toggle disabled by default; requires age verification
- Additional Metadata: Full-cast audio export, offline playback

---

## CoreForge Visual
- Bundle ID: `com.coreforge.visual`
- Target Platforms: iOS, Android, macOS, Windows
- Exported as: `.ipa`, `.apk`, `.dmg`, `.exe`
- Required Permissions: photo/video access, storage
- App Store Notes: Multiverse scenes and NSFW mode require login
- Additional Metadata: Book-to-video AI engine, supports export for TikTok, Reels, YouTube

---

## CoreForge Writer
- Bundle ID: `com.coreforge.writer`
- Exported as: `.ipa`, `.apk`, `.dmg`
- Required Permissions: file read/write
- App Store Notes: Supports story-to-novel transformation and AI expansion
- Metadata: Creative writing sandbox, export to eBook/PDF

---

## CoreForge Studio
- Bundle ID: `com.coreforge.studio`
- Platforms: All
- Notes: Multi-layer editor for visual+audio+FX app creation
- Metadata: Ideal for creators with voice + video workflows

---

## CoreForge Market
- Bundle ID: `com.coreforge.market`
- Notes: Requires legal disclaimer for investment and trading simulations
- Metadata: Titan Engine, live simulation, arbitrage, and sentiment AI

---

## CoreForge Mind / Bloom
- Bundle ID: `com.coreforge.mind` / `com.coreforge.bloom`
- Notes: Mental health category, requires disclaimer and adult user toggle
- Metadata: AI therapy, journaling, coaching, NSFW (opt-in)

---

## CoreForge Build
- Bundle ID: `com.coreforge.build`
- Export: All platforms supported
- Metadata: AI-powered app builder, exports to `.ipa`, `.apk`, `.dmg`, `.exe`, and Web

---

## CoreForge DNA / Voice Lab
- Bundle ID: `com.coreforge.dna`, `com.coreforge.voicelab`
- Notes: Audio/visual DNA-based training tools for character voice, multiverse identity

---

## CoreForge Learn
- Bundle ID: `com.coreforge.learn`
- Notes: Education category, integrates curriculum and progress tracking
- Metadata: Ideal for licensing to schools and institutions

---

## Final Checklist
- [ ] Screenshots and icons uploaded
- [ ] Metadata finalized
- [ ] Build signed and verified
- [ ] Privacy Policy linked
- [ ] TestFlight (Apple) and Internal Track (Google) verified

