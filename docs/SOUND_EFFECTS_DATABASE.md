# Sound Effects Database

This document lists the built‑in sound effect records that ship with the CreatorCoreForge ecosystem. Each record references a short audio clip used across apps for ambience, UI feedback, combat scenes and more.

## Categories

- **Interface** – taps, swipes and notification beeps
- **Combat** – weapon swings, clashes and explosions
- **Nature** – outdoor ambiences like rain or forests
- **Sci‑Fi** – futuristic whooshes and lasers
- **NSFW** – sensual cues and heavy breathing (age‑gated)

## Adding Records

Sound effects are stored in `SoundEffectsDatabase` located under `Sources/CreatorCoreForge`. Packs of effects are registered through `SFXPackManager` so that they can be played sequentially via `SoundEffectManager`.

To add a new effect, extend `SoundEffectsDatabase` with another `Record` specifying its name, category and NSFW flag. Packs may then include these effects by name.
