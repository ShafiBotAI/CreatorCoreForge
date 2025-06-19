# Inkwell AI

Inkwell AI is a writing assistant focused on book creation. The iOS client is
built with SwiftUI while desktop versions target Electron and .NET MAUI.

## Key Features
- **Series-based memory** for tracking characters and plots
- **Genre templates** with fast draft mode
- **Promo code unlocks** for additional content
- **Video sharing** to social platforms
- **Export to ePub, PDF, and audiobook formats** via `BookExporter`
- **Bestseller structure engine** for common outlines
- **Multi-book generation** supporting large series
- **NSFW toggle with parental PIN lock**

## Building (iOS)
1. Open `InkwellAIFull/InkwellAI.xcodeproj` in Xcode.
2. Select the **InkwellAI** scheme and run on your device or simulator.

## Offline Mode
Enable the environment variable `USE_LOCAL_AI=1` to run Inkwell AI without
network access. The shared `FusionEngine` will automatically select
`LocalAIEnginePro` to generate responses locally.
