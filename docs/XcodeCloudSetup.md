# Xcode Cloud Setup

This guide explains how to build **CoreForge Audio** using Xcode Cloud.

1. Commit the workflow file `.xcodecloud/workflows/coreforgeaudio.yml` to your repository.
2. In Xcode, open the **Report Navigator** and choose **Xcode Cloud** → **Configure in Cloud**.
3. Select the **CoreForgeAudio** project and choose the *CoreForgeAudio CI* workflow.
4. Provide `OPENAI_API_KEY` and `ELEVEN_API_KEY` secrets under **Environment Variables**.
5. Run the workflow to build and test the app on Apple's servers. Artifacts appear in the Xcode Cloud dashboard.

Refer to `apps/CoreForgeAudio/DeveloperSetup.md` for local build prerequisites.
