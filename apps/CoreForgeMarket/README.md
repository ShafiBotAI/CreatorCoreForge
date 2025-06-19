# CoreForge Market

CoreForge Market assists traders with strategy ideas and market sentiment analysis.
The project uses Swift packages to interact with the OpenAI API and other
services.

## Key Features
- **Financial NLP** powered by OpenAI
- **Sentiment detector** with chart markup tools
- **Trading journal** with offline sentiment scoring
- **Chart screenshot analysis** for quick trend detection
- **Multi-market scanner** with basic smart money metrics
- **Real-time sentiment heatmap** for journal entries
- **Journal storage** via Firebase (stubbed)
- **Video sharing** to social media accounts
- **Auto-update checks** using the shared `AutoUpdater` module

## Building (Swift Package)
1. Open `TradeMindAIFull` in Xcode and run `swift test`.
2. Configure `OPENAI_API_KEY` for integration tests when needed.

## Offline Mode
CoreForge Market can operate without network connectivity. Set `USE_LOCAL_AI=1`
before running to route prompts through `LocalAIEnginePro` via `FusionEngine`.

