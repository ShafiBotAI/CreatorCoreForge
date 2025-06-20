# CoreForge Audio

CoreForge Audio is a voice-driven reader that supports offline playback and a secure
vault system. It is written in SwiftUI and will expand to additional platforms.

## Key Features
 - **Voice assignment** for characters via `CharacterVoiceMapper`
- **Dark mode** and theme toggles
- **Offline audio storage** with stealth vault option
- **Offline download queue management**
- **Import ePub, PDF, and TXT files** via `EbookImporter`
- **Video sharing** to social networks
- **Audiobook compilation** with `AudiobookCompiler` for zipped exports

When Stealth Vault is enabled in the Settings screen, downloaded audio is
stored in a hidden directory so it won't appear in the Files app.

## Building (iOS)
1. Open `VocalVerseFull/VocalVerse.xcodeproj` in Xcode.
2. If the **VocalVerse** scheme is missing, create a new scheme that targets the
   `VocalVerse` application target and mark it as shared ("Manage Schemes" ->
   **Shared**). This ensures `xcodebuild` can detect the scheme when building
   from the command line.
3. Select the **VocalVerse** scheme and build or run.

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
The project now includes a basic launch screen and placeholder app icon set so
that Xcode archives can pass initial App Store validation. Permissions for
microphone access and photo library usage are defined in `Info.plist`, and API
keys can be securely stored using `SecureStore.storeApiKey` which writes the
value to the iOS Keychain.
An `AppStoreAssets` directory provides placeholders for screenshots and
additional artwork required by the store.
