# CoreForge Studio

CoreForge Studio converts written works into dramatized videos with AI-generated
voices and visuals. The Swift package contains scene generation and rendering
utilities.

## Key Features
- **Scene-by-scene dramatization**
 - **Voice casting engine** with `CharacterVoiceMapper` integration
- **Book-to-video rendering** with style presets
- **Share rendered videos** to social media

## Building (Swift Package)
1. Open `VocalVisionFull` in Xcode and run `swift test`.

## Offline Mode
CoreForge Studio uses the shared `FusionEngine` for AI tasks. Define
`USE_LOCAL_AI=1` to force `LocalAIEnginePro` and work without OpenAI access.
