# VoiceLab

VoiceLab provides TypeScript utilities and components for voice analysis and transcription used by the CreatorCoreForge ecosystem. Run `npm install` then `npm test` to build and test the package.
- Includes **UnifiedAudioEngine** for global volume control and fade transitions across web tools.

## API Highlights

- `LocalVoiceAI` – train and export local voice models.
- `VoiceAnalyticsService` – analyze pitch and tone from audio blobs.

See `scripts/train-sample.ts` for a CLI example that trains a sample model.

## n8n Assistant Wrapper

VoiceLab ships with a lightweight AI assistant inspired by the n8n `OpenAiAssistant` node. The helper lives in `src/n8nAssistant.ts` and forwards prompts through our `openaiService`. Use `runN8nAssistant(text, options)` to generate responses or automate voice workflows locally.
