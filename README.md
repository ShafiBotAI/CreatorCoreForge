# CreatorCoreForge

This repository collects multiple experimental iOS projects that integrate AI-driven features. Each app lives under `apps/`.

- **LoreForgeAI** – video and story creation suite. See `apps/LoreForgeAI/README.md`.
- **VocalVerse** – voice-controlled reader with offline vault. See `apps/VocalVerse/README.md`.
- **DataForgeAI** – data analysis utilities. See `apps/DataForgeAI/README.md`.
- **VerseForgeAI** – beat and hook generation tools. See `apps/VerseForgeAI/README.md`.
- **InkwellAI** – book publishing assistant. See `apps/InkwellAI/README.md`.
- **TradeMindAI** – trading strategy companion. See `apps/TradeMindAI/README.md`.

Recent updates introduce advanced AI stubs across all apps to prepare for next-generation features.
The shared `VoiceMemoryManager` now supports exporting and importing assignments
so creators can sync character voice selections across apps.

TestFlight workflows are provided under `.github/workflows` for continuous delivery.
Pushes to `main` automatically run `fastlane-testflight.yml` which builds the iOS
projects (VocalVerse, LoreForgeAI, and InkwellAI) and uploads them to TestFlight
using the `build_and_upload` lane. Configure `APPSTORECONNECT_*` secrets in your
repository so the workflow can authenticate with App Store Connect. You can also
manually trigger `upload-testflight.yml` from the Actions tab when a one-off
build is ready for distribution.

For production releases, trigger `upload-appstore.yml` which calls the
`build_and_deliver` lane to submit the apps directly to App Store Connect.

See `docs/AI-Prompt-Migration.md` for integrating the new OpenAI prompt interface across apps.
All apps now include a `VideoShareManager` for posting generated videos directly to social media.
The new `FusionEngine` wrapper automatically selects between `LocalAIEnginePro` and `OpenAIService` for each app, enabling offline-first development when `USE_LOCAL_AI` is set.


## OpenAI Setup

Copy `.env.example` to `.env` and provide your `OPENAI_API_KEY` before running any app or tests. The shared `OpenAIService` reads this value at runtime.
A shared `ContentPolicyManager` now manages NSFW filtering across apps.
For offline development you can set `USE_LOCAL_AI=1` in the environment to enable `LocalAIEnginePro`, a lightweight local model stub that replaces OpenAI calls.

## Global Missing Items

The following components are planned across all apps but are still works in progress:

- [x] Shared `AutoUpdater.swift` module
- [ ] Programmatically generated `.pbxproj` project files
- [ ] App Store assets (`AppIcon.appiconset`, LaunchScreens)
- [ ] Final production UI polish
- [ ] `.dmg` and `.exe` installers following `.ipa` builds

