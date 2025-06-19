# OpenAI Integration Guide

This document outlines the steps to integrate OpenAI services for the TradeMind AI app.

## Account Setup
1. Ensure an OpenAI organization with billing enabled.
2. Set usage and budget alerts in the OpenAI dashboard.
3. Generate API keys for development, staging, and production environments and store them securely (Keychain or CI secrets).
4. Invite the development and QA teams with appropriate roles.
5. Request a rate-limit increase if required by the app.

## Model & Prompt Configuration
- Use `gpt-3.5-turbo` for chat completions and embeddings for similarity.
- Provide prompt templates for market-news sentiment, strategy recommendation, and company similarity search.
- Optional: fine-tune on historical trade data.

## SDK & Code Integration
- Install the OpenAI Swift SDK via Swift Package Manager.
- Configure `OPENAI_API_KEY` for Beta/TestFlight schemes.
- Implement `OpenAIService` as a shared wrapper with headers, timeouts, and retry logic.
- Add a prompt-template loader (e.g. JSON files in the app bundle).
- Integrate the embeddings API for similarity queries.

## Testing
- Write unit tests using a mocked OpenAI client.
- Add integration tests with a sandbox key to validate sentiment analysis and embeddings.
- Monitor latency and build golden-file tests to detect prompt regressions.

## Security & Compliance
- Never commit API keys to the repository.
- Mask any PII before sending requests to OpenAI.
- Update the Privacy Policy to mention third-party AI usage and ensure compliance with OpenAI policies.

## Monitoring & Cost Control
- Log token and request usage.
- Send alerts to Slack or email for cost spikes or API errors.

## TestFlight Preparation
- Ensure the Beta scheme includes environment variables for the API key.
- Update `Info.plist` with necessary network permissions.
- Document how testers inject keys.
- Archive and upload the build to App Store Connect.
- Draft release notes highlighting the new AI capabilities.

## Support

If you run into issues integrating OpenAI services or have questions about
usage limits, please open an issue on GitHub. Include device logs and any
relevant error messages when possible. For private matters or security concerns
you can reach the maintainers at `support@example.com`.

Feature requests and general discussions are welcome in the Discussions tab of
the repository.

## Multi-App Interface
All applications now include `OpenAIService` and `PromptTemplateLoader` for standardized prompts. See `docs/AI-Prompt-Migration.md` for migration steps.
For local development copy `.env.example` to `.env` and supply your `OPENAI_API_KEY`. This file is ignored by git.
