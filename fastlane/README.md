# Fastlane

Configuration files for iOS TestFlight distribution. `Fastfile` defines lanes for building and uploading builds.

## Usage

Run lanes via `bundle exec fastlane`.

### Build and Upload a Single App

```
PROJECT_PATH=../apps/CoreForgeWriter/CoreForgeWriter.xcodeproj \
SCHEME=CoreForgeWriter bundle exec fastlane build_and_upload
```

### Build All Apps

```
bundle exec fastlane build_all
```

`build_all` searches for every `.xcodeproj` under `../apps` and runs `build_and_upload` with the matching scheme. Projects under `openai-swift` are skipped.
