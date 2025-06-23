# progress_bot.py

`progress_bot.py` helps track completion progress for each CreatorCoreForge app using `docs/OPEN_TASKS.md`. The script parses the checklist-style file and reports how many features are implemented versus incomplete. With OpenAI installed and an API key configured, `progress_bot.py` can also generate code snippets for missing tasks.

## Usage

```bash
python scripts/progress_bot.py
```

The script prints a progress percentage for each app. When the `openai` package is installed and the `OPENAI_API_KEY` environment variable is set, it will suggest code for the first incomplete item it finds.

