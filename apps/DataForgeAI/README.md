# DataForge AI

DataForge AI provides intelligent lead generation and prospecting tools.
The iOS framework is built with Swift and includes workflow automation
for scoring leads and tracking signals.

## Key Features
- **Real-time signal tracking** with simple analytics
- **Automated prospecting workflows** using heuristics
- **Multilingual targeting** across regions
- **Lead scoring engine** to prioritize outreach
- **Share insight videos** to social networks
- **Marketplace credits** for buying premium leads

## Building (Swift Package)
1. Navigate to `DataForgeAIFull` and open the package in Xcode.
2. Run `swift test` to ensure all unit tests pass.

## Offline Mode
When `USE_LOCAL_AI=1` is set in the environment, DataForge AI will use
`LocalAIEnginePro` through the shared `FusionEngine` for all AI prompts. This
allows lead generation features to work without network connectivity.
