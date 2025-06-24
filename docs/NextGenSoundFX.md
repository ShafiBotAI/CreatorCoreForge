# Next Gen Sound Effects

The `scripts/generate_sound_effects.py` tool can synthesize simple environment
and human sound effects without any external dependencies. Generated files are
standard 44.1 kHz mono WAV audio.

## Usage

```bash
python scripts/generate_sound_effects.py wind wind.wav
python scripts/generate_sound_effects.py clap clap.wav --duration 1.5
```

Supported effects include:

- Environment: `wind`, `rain`, `footsteps`
- Human: `clap`, `breath`

The script is experimental but demonstrates how CreatorCoreForge can create
sound assets programmatically.
