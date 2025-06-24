"""Simple utilities to join two scenes with a crossfade."""
from __future__ import annotations

from pydub import AudioSegment


def crossscenefxlinking(scene_a: AudioSegment, scene_b: AudioSegment, crossfade_ms: int = 1000) -> AudioSegment:
    """Return ``scene_a`` followed by ``scene_b`` with ``crossfade_ms`` overlap."""
    crossfade_ms = max(0, min(len(scene_a), crossfade_ms))
    return scene_a.append(scene_b, crossfade=crossfade_ms)


__all__ = ["crossscenefxlinking"]
