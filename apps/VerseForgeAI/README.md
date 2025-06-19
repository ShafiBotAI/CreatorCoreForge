# VerseForge AI

VerseForge AI helps musicians craft hooks, lyrics, and beats. The package is
implemented in Swift and designed for cross-platform use, including a DAW plugin
in future releases.

## Key Features
- **AI lyric generator** by genre and mood
- **Hook generator** and song templates
- **A/B hook split testing** with virality scoring
- **Beat matching** and integrated **beat marketplace**
- **Hitmaker toolkit** with Song DNA engine
- **Explicit lyric filtering** powered by `ContentPolicyManager`
- **Auto-pitch** demos directly to labels
- **Community collaboration** and sharing tools
- **Licensing engine** for commercial and sync use
- **DAW plugin mode** for VST/AU hosts
- **Share song preview videos** to social channels

## Building (Swift Package)
1. Open `VerseForgeAIFull/Package.swift` in Xcode.
2. Run the included unit tests with `swift test`.

## Offline Mode
`USE_LOCAL_AI=1` enables offline operation through `LocalAIEnginePro`.
`FusionEngine` automatically switches to the local engine when this variable is
set.
