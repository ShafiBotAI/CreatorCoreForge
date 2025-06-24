# auto_code_bot.py

`auto_code_bot.py` scans the repository for incomplete features listed in `AGENTS.md` files. For each missing task it now generates a language-specific placeholder file under the `generated/` directory. When the `openai` package is installed and `OPENAI_API_KEY` is set, the bot attempts to generate code with OpenAI. Without OpenAI, it creates an advanced offline stub that detects the desired language (Swift, Kotlin, TypeScript, or Python) and builds a minimal class or function skeleton. The script also performs a quick syntax check on all Python files and comments out any lines that fail to compile so the project can build entirely offline.

## Usage

```bash
python scripts/auto_code_bot.py
```

To replace existing placeholder files with new code generated via OpenAI, run:

```bash
python scripts/auto_code_bot.py --upgrade-placeholders
```

The script outputs generated files in subdirectories of `generated/`, one per app. These files are safe to edit or replace with full implementations.

Generated filenames now match the detected language. For example, a Swift feature results in `feature.swift`, while a Python task becomes `feature.py`. Every run also scans existing Python files and comments out lines with syntax errors to keep the repository importable when offline.


### New Features

- `--tasks-file my_tasks.txt` – optionally generate code for custom task lines
  contained in `my_tasks.txt`. Generated files are placed under
  `generated/manual/`.
- Offline mode now detects common keywords and produces more complete templates
  for CLI scripts, simple Flask APIs, or contact registries when OpenAI is not
  available.
=======
In addition to the `generated/` folder, each run now writes a copy of the snippet into language specific folders under `output/`. The filename is suffixed with a timestamp for easy version tracking, e.g. `output/python/login_handler_20240101123000.py`.
