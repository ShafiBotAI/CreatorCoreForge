# Auto-generated for Ensure CoreForge Audio checklist includes all phases 1-9 features
"""Verify ``CoreForgeAudio`` in ``features-phase8.json`` lists at least 200 features."""

from __future__ import annotations

import json
from pathlib import Path


def ensure_coreforge_audio(json_path: str = "features-phase8.json") -> int:
    """Validate the CoreForge Audio feature checklist.

    Parameters
    ----------
    json_path: str
        Path to ``features-phase8.json``.

    Returns
    -------
    int
        Number of features detected for CoreForge Audio.
    """

    path = Path(json_path)
    if not path.exists():
        raise FileNotFoundError(path)

    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)

    features = data.get("phase8Features", {}).get("CoreForgeAudio", [])
    count = len(features)
    if count < 200:
        raise ValueError(f"CoreForgeAudio has only {count} features; expected >= 200")

    print(f"CoreForgeAudio feature count: {count}")
    return count


if __name__ == "__main__":
    ensure_coreforge_audio()

