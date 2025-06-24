# Next Gen Adaptive Music

The `scripts/generate_adaptive_music.py` utility creates short mood-based music loops without any external dependencies. Each track is a 44.1 kHz mono WAV file derived from a basic sine wave.

## Usage

```bash
python scripts/generate_adaptive_music.py calm calm.wav
python scripts/generate_adaptive_music.py tense tense.wav --duration 2.5
```

Supported moods include:

- `calm`
- `tense`
- `happy`
- any other label defaults to a neutral tone

This script demonstrates the AdaptiveMusicGenerator concept for quickly prototyping soundtrack ideas.
