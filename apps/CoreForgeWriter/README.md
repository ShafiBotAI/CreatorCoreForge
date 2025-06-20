# CoreForge Writer

CoreForge Writer is a writing assistant focused on book creation. The iOS client is built with SwiftUI while desktop versions target Electron and .NET MAUI.

## Key Features
- **Series-based memory** for tracking characters and plots
- **Genre templates** with fast draft mode
- **Promo code unlocks** for additional content
- **Video sharing** to social platforms
- **Export to ePub, PDF, and audiobook formats** via `BookExporter`
- **Automatic character voice mapping** with `CharacterVoiceMapper`
- **Bestseller structure engine** for common outlines
- **Multi-book generation** supporting large series
- **Import ePub, PDF, and TXT files** via `EbookImporter`
- **NSFW toggle with parental PIN lock**
- **NSFW habit behavior simulator** for vocal reactions during narration

## Building (iOS)
1. Open `InkwellAIFull/InkwellAI.xcodeproj` in Xcode.
2. Select the **InkwellAI** scheme and run on your device or simulator.

## Offline Mode
Enable the environment variable `USE_LOCAL_AI=1` to run CoreForge Writer without
network access. The shared `FusionEngine` will automatically select
`LocalAIEnginePro` to generate responses locally.
