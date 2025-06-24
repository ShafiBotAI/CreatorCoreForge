# CoreForge Audio

CoreForge Audio is a voice-driven reader that supports offline playback and a secure
vault system. It is written in SwiftUI and will expand to additional platforms.

## Key Features
 - **Voice assignment** for characters via `CharacterVoiceMapper`
 - **Voice variant creation** with `VoiceDNAForker`

- **Dark mode** and theme toggles
=======
 - **Dark mode** and theme toggles via `ThemeManager`

- **Offline audio storage** with stealth vault option
- **Offline download queue management**
- **Sleep Read Mode** with fade-out timer
- **Dynamic emotion cues** with `AIEmotionEngine`
- **Import ePub, PDF, and TXT files** via `EbookImporter`
- **Video sharing** to social networks
- **NSFW content manager** to log and filter explicit scenes
- **NSFW habit behavior simulator** for character-specific response sounds

- **Audiobook compilation** with `AudiobookCompiler` for zipped exports
- **Scene memory simulator** for replaying chapters in different moods
- **Multi-cast audiobook generation** via `MultiCastAudiobookGenerator`
- **Immersive dramatized production** with `DramatizedAudiobookProducer`


When Stealth Vault is enabled in the Settings screen, downloaded audio is
stored in a hidden directory so it won't appear in the Files app.

## Core Library Integration

CoreForge Audio reuses modules from the shared `CreatorCoreForge` package. If
you notice missing playback or export features, ensure the package is linked in
Xcode and reference `Sources/CreatorCoreForge/CoreForgeAudio_MissingFeatures.swift`
for additional helper functions. These utilities provide an offline download
queue and an eBook–to–audio converter that complement the app's own classes.
For advanced conversions using the Python pipeline, run `../../scripts/ebook2audiobook_bridge.py MyBook.epub`.
You can also turn a dialogue script into audio using `../../scripts/chatterbox_bridge.py script.txt` once your Chatterbox API endpoint is configured.


## Building (iOS)
1. Open `CoreForgeAudio.xcodeproj` in Xcode.
2. If the **CoreForgeAudio** scheme is missing, create a new scheme that targets
   the `CoreForgeAudio` application target and mark it as shared ("Manage Schemes"
   → **Shared**). This ensures `xcodebuild` can detect the scheme when building
   from the command line.
3. Select the **CoreForgeAudio** scheme and build or run.

## Environment Configuration
Set the following environment variables in your Xcode scheme or `.env` file:
- `OPENAI_API_KEY` for OpenAI access
- `ELEVEN_API_KEY` for ElevenLabs voice synthesis
- Firebase will read configuration from `GoogleService-Info.plist`

## Offline Mode
Set `USE_LOCAL_AI=1` to use `LocalAIEnginePro` for narration and chapter
segmentation. `FusionEngine` will fall back to the local engine when the
variable is detected.

## App Store Compliance
The project now includes a basic launch screen and app icon set so
that Xcode archives can pass initial App Store validation. Permissions for
microphone access and photo library usage are defined in `Info.plist`, and API
keys can be securely stored using `SecureStore.storeApiKey` which writes the
value to the iOS Keychain.
An `AppStoreAssets` directory provides screenshots and
additional artwork required by the store.

## App Capabilities

Highlighted capabilities from `features-phase8.json`:
- UnifiedAudioEngine
- UnifiedVideoEngine
- AdaptiveLearningEngine
- Real-time emotion adaptation
- Voice DNA visualization
