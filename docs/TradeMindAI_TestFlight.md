# TradeMind AI TestFlight Guide

This document outlines the steps to distribute TradeMind AI via TestFlight.

1. **API Keys**: Set `OPENAI_API_KEY` in the Beta scheme environment variables.
2. **Info.plist**: Ensure network permissions are configured for HTTPS.
3. **Archive**: Use Xcode's *Product → Archive* with the Beta scheme.
4. **Upload**: Upload the build to App Store Connect and create a TestFlight build.
5. **Testers**: Invite testers and share instructions for setting the API key under Settings → TradeMind AI.

Once your App Store Connect credentials are stored as repository secrets, you can
trigger the **Upload Apps to TestFlight** workflow from the GitHub Actions tab.
This workflow uses Fastlane to archive the project and automatically distribute
the build to TestFlight.

## Beta Checklist

Before distributing the beta build, verify the following:

1. The `OPENAI_API_KEY` environment variable is present. `OpenAIService` now
   provides a convenience initializer that automatically reads this key, so the
   app will fail to launch if it is missing.
2. Run `swift test` to ensure unit and integration tests pass. If the Swift
   package dependencies cannot be fetched due to network restrictions, supply a
   local copy of the `openai-swift` package within the project.
3. Review release notes and confirm that any prompts or strategy templates are
   up to date in `prompts.json`.
4. Ensure the privacy policy and App Store metadata mention usage of OpenAI
   services.
