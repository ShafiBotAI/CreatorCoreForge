# CoreForge Audio

CoreForge Audio is a voice-driven reader that supports offline playback and a secure
vault system. It is written in SwiftUI and will expand to additional platforms.
## Key Features

 - **Voice assignment** for characters via `CharacterVoiceMapper`
 - **Voice variant creation** with `VoiceDNAForker`
 - **Voice cleanup utility** via `voice_cleaner.py` for high-quality training
- **Dark mode** and theme toggles
 - **Dark mode** and theme toggles via `ThemeManager`

- **Offline audio storage** with stealth vault option
- **Offline download queue management**
- **Sleep Read Mode** with fade-out timer
 - **Dynamic emotion cues** with `AIEmotionEngine`
 - **Import ePub, PDF, and TXT files** via `EbookImporter`
 - **Google and Apple account login support** for quick sign in
 - **Video sharing** to social networks
 - **NSFW content manager** to log and filter explicit scenes
- **NSFW habit behavior simulator** for character-specific response sounds

- **Audiobook compilation** with `AudiobookCompiler` for zipped exports
- **Scene memory simulator** for replaying chapters in different moods
- **Multi-cast audiobook generation** via `MultiCastAudiobookGenerator`
- **VoiceRevisionManager** allows five full audiobook voice changes within the first 30 days
- **Immersive dramatized production** with `DramatizedAudiobookProducer`
- **Dashboard** tab with usage analytics and achievements
- **Favorite Voices** tab for quickly selecting preferred voices
- **Highlighted reading** during playback
 - **Free 5-minute samples** with customizable voice and playback settings


### Additional Features from Audiobookshelf
The following capabilities are inspired by the open-source
[audiobookshelf](https://github.com/advplyr/audiobookshelf) project and
are planned for future integration:
 - **Stream all audio formats** on the fly
 - **Podcast search and auto-download** support
 - **Multi-user libraries** with custom permissions
 - **Progress sync** across devices per user
 - **Automatic library updates** without manual re-scans
 - **Bulk drag-and-drop uploads** for books and podcasts
 - **Metadata backup** with optional daily automation
 - **Progressive Web App** (PWA) compatibility
 - **Chromecast** casting on web and Android
 - **Metadata fetch** and cover art lookup
 - **Chapter editor** with Audnexus lookup
 - **Merge audio files** into single `.m4b` outputs
 - **Embed metadata** and cover images during export
 - **Extended ebook support** (epub, pdf, cbr, cbz) with Kindle send
 - **Open RSS feed** support for podcasts and audiobooks
=======
- **Advanced offline TTS** via the bundled `ebook2audiobook` pipeline (XTTSv2,
  Bark, Vits and more) with support for 1110+ languages and optional voice
  cloning
- **Custom TTS model uploads** to further improve voice fidelity
=======
- **Batch ebook conversion** via `convert_folder_to_audio` or
  `scripts/ebook2audiobook_batch.py`
- **Advanced voice extraction** with `voice_cleaner.py --extract` for
  noise-free training samples



When Stealth Vault is enabled in the Settings screen, downloaded audio is
stored in a hidden directory so it won't appear in the Files app.

## Core Library Integration

CoreForge Audio reuses modules from the shared `CreatorCoreForge` package. If
you notice missing playback or export features, ensure the package is linked in
Xcode and reference `Sources/CreatorCoreForge/CoreForgeAudio_MissingFeatures.swift`
for additional helper functions. These utilities provide an offline download
queue and an eBook–to–audio converter that complement the app's own classes.
For advanced conversions using the Python pipeline, call
`convert_ebook_to_audio("MyBook.epub")` from `audio_utils.py` or run
`../../scripts/ebook2audiobook_bridge.py MyBook.epub`.
To polish training samples, run `services/voice_cleaner.py AUDIO.wav` and use the resulting file in `VoiceTrainer`.
For final mastering you can call `advanced_normalize_wav_file` or
`advanced_normalize_wav_folder` from `audio_utils.py` to apply the
ebook2audiobook FFmpeg pipeline for consistent levels and tone.
Use `convert_folder_to_audio` to process an entire directory of ebooks, and
`voice_cleaner.py --extract` to generate clean voice models.
You can also turn a dialogue script into audio using `../../scripts/chatterbox_bridge.py script.txt` once your Chatterbox API endpoint is configured.


## ebook2audiobook Integration

This repository bundles a snapshot of the open source
[`ebook2audiobook`](../ebook2audiobook) project under `apps/ebook2audiobook`.
It provides a CPU/GPU narration pipeline capable of handling over 1110
languages and optional voice cloning. Install its Python requirements and run
`scripts/ebook2audiobook_bridge.py` to convert entire eBooks offline. The
pipeline works on machines with as little as **4GB RAM** (8GB recommended) and
supports custom TTS model uploads for higher quality results.
=======
Full details on the Python-based feature set live in
[`../ebook2audiobook/FEATURES-CODEX-COMPLETE.md`](../ebook2audiobook/FEATURES-CODEX-COMPLETE.md).
Install the optional pipeline as described in `DeveloperSetup.md` to unlock
these advanced converters.


## Building (iOS)
1. Open `CoreForgeAudio.xcodeproj` in Xcode.
2. Verify the `CreatorCoreForge` package appears under Swift Package Dependencies.
3. If the **CoreForgeAudio** scheme is missing, create a new scheme that targets
   the `CoreForgeAudio` application target and mark it as shared ("Manage Schemes"
   → **Shared**). This ensures `xcodebuild` can detect the scheme when building
   from the command line.
4. Select the **CoreForgeAudio** scheme and build or run.

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
