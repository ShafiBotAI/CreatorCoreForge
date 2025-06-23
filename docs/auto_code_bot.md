# auto_code_bot.py

`auto_code_bot.py` scans the repository for incomplete features listed in `AGENTS.md` files. For each missing task it now generates a language-specific placeholder file under the `generated/` directory. When the `openai` package is installed and `OPENAI_API_KEY` is set, the bot attempts to generate code with OpenAI. Without OpenAI, it creates an advanced offline stub that detects the desired language (Swift, Kotlin, TypeScript, or Python) and builds a minimal class or function skeleton. The script also performs a quick syntax check on all Python files and comments out any lines that fail to compile so the project can build entirely offline.

## Usage

```bash
python scripts/auto_code_bot.py
```

The script outputs generated files in subdirectories of `generated/`, one per app. These files are safe to edit or replace with full implementations.

Generated filenames now match the detected language. For example, a Swift feature results in `feature.swift`, while a Python task becomes `feature.py`. Every run also scans existing Python files and comments out lines with syntax errors to keep the repository importable when offline.
