# Practical Approach and Initial TODO List

This document outlines a phased plan for implementing the key features across the CreatorCoreForge ecosystem. It consolidates the large task lists into a focused starting point so contributors can prioritize work.

## 1. Foundation

1. **Shared Modules** – ensure `FusionEngine`, `LocalAIEngine`, and `LocalVoiceAI` are integrated across apps. Update `Package.swift` targets and maintain cross-app modules in `Sources`.
2. **CI Setup** – verify all workflows in `.github` run on pull requests. Update scripts in `fastlane` and `scripts` directories to support automated builds and tests.
3. **Testing** – run `swift test` and `npm test` (for `VisualLab` and `VoiceLab`) regularly. Expand coverage in `Tests` as new modules land.

## 2. CoreForge Audio

1. **Book Importer** – implement EPUB/PDF/TXT parsing to produce an array of `Chapter` objects with metadata.
2. **Chapter Detection** – add logic and GPT prompts to locate chapter boundaries in raw text.
3. **Segment Service** – split chapters into narration-ready segments with semantic boundaries.
4. **Voice Manager** – map segments to voice models and persist character mappings.
5. **TTS Service** – interface with ElevenLabs or LocalVoiceAI to render audio, including retry logic.
6. **Ambient Mixer** – layer ambience and SFX with volume envelopes and 3D positioning.
7. **NSFW Service** – detect explicit text, gate content, and enforce parental PIN checks.
8. **Playback Engine** – implement basic `play`, `pause`, and `seek` controls with a simple React UI.

## 3. CoreForge Visual

1. **Storyboard Importer** – parse input files into structured scenes.
2. **Scene Segmenter** – break scenes into shots using GPT guidance.
3. **Style Engine** – apply rendering presets (anime, live-action, fantasy).
4. **Frame Renderer** – assemble frames into clips with transitions and audio sync.

## 4. CoreForge Writer

1. **Outline Generator** – produce outlines with acts and scenes via GPT.
2. **World Memory Service** – persist lore, characters, and settings for reuse.
3. **Branch Service** – allow “what-if” story branching.
4. **Export Service** – support ePub and Docx generation with proper metadata.

## 5. CoreForge Studio

1. **MultiTrack Editor** – add track operations and threaded mixdown.
2. **Live Ensemble Room** – sync streams and chat between participants.
3. **Macro Workflow Engine** – record UI actions and replay as scripts.
4. **Export Production** – output MP4/MOV/WAV/MP3 with optional watermarks.

## Next Steps

- Tackle one feature at a time, starting with the Audio importer and chapter detection.
- Keep `docs/PHASE_EIGHT.md` in sync with `features-phase8.json` as features progress.
- Update `CHANGELOG.md` when major milestones are reached.

This checklist provides a practical starting point while leaving room for the advanced Phase 8 capabilities.
