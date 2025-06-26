# Xcode Cloud Setup

This guide explains how to configure an iOS build branch for testing with Xcode Cloud.

1. Create a feature branch in your fork:
   ```bash
   git checkout -b xcode-cloud
   ```
2. Add the workflow file located at `.xcodecloud/workflows/default.yml` to your branch.
3. Push the branch to your repository and open it in Xcode.
4. Choose **Xcode Cloud** from the Product menu and create a new workflow using the YAML file.
5. Each commit to the branch triggers a build of the `CoreForgeStudio` scheme and runs `swift test`.

Refer to Apple's documentation for advanced configuration options.
