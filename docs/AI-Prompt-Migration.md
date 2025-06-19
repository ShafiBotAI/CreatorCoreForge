# AI Prompt Migration

Each app now ships with a unified `OpenAIService` and `PromptTemplateLoader`. The service reads the `OPENAI_API_KEY` environment variable and exposes helper methods for chat completions and embeddings.

To migrate existing features to the new prompt system:

1. Add `OpenAIService` to your view models or controllers.
2. Load templates using `PromptTemplateLoader(bundle:)`.
3. Replace hard coded prompts with entries from `prompts.json`.
4. Inject the API key via Xcode scheme or environment configuration.
5. Run unit tests for the package to ensure prompts load correctly.

All apps include a `prompts.json` file under their sources directory with starter templates. Customise these prompts for your workflow and expand as needed.
