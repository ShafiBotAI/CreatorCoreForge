# AppForge AI

AppForge AI is an AI-powered app builder that generates code and bundles for multiple platforms. It integrates with Figma, GitHub, and popular IDEs to streamline development.

## Key Features
- **App idea generator** that analyzes trending topics
- **UI builder** leveraging Figma templates
- **Codex engine** producing Swift, Kotlin, Python, Unity, and JavaScript
- **Automatic GitHub and IDE integration**
- **Monetization logic builder** for subscriptions and in-app purchases
- **Virality engine** with upload integration
- **Auto bundler** for iOS, Android, PC, and VR

## Offline Mode
Set the environment variable `USE_LOCAL_AI=1` to route all AI requests through
`LocalAIEnginePro`. This enables offline development and testing without the
OpenAI API. The shared `FusionEngine` automatically detects the variable and
switches engines.
