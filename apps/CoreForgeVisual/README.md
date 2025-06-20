# CoreForge Visual

CoreForge Visual is a cross-platform tool for generating video and story content. The iOS client is written in **SwiftUI** while the desktop version targets Electron and .NET MAUI.

## Key Features
- **AI scene dramatization engine** for turning text into short clips
- **Cinematic rendering styles** such as anime, live action, and storyboard
- **Multilingual content generation** with automatic language selection
- **Adaptive AI memory** to maintain story and character continuity
- **NSFW toggle** with a stealth vault for private content
- **NSFW habit behavior simulator** for triggering custom SFX cues
- **Auto-upload and social sharing** to platforms like YouTube and TikTok
- **Virality Engine** with a publishing scheduler
- **Lore compression tool** for summarizing long passages
- **Character stat tracker** to manage RPG-style attributes
- **Import ePub, PDF, and TXT files** via `EbookImporter`

## Building (iOS)
1. Open `LoreForgeAI.xcodeproj` found in `LoreForgeAIFull`.
2. Select the **LoreForgeAI** scheme and your target device or simulator.
3. Build and run from Xcode. TestFlight builds are handled via GitHub Actions.


## Environment Configuration
Configure these variables or files before building:
- `OPENAI_API_KEY` for chat completions
- `ELEVEN_API_KEY` if using voice features
- Include `GoogleService-Info.plist` for Firebase

## Offline Mode
CoreForge Visual supports offline development. Set `USE_LOCAL_AI=1` to activate
`LocalAIEnginePro` via `FusionEngine` and bypass the OpenAI API.
