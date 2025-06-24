# Auto-generated for FlashbackSceneEngine
"""Apply a flashback-style audio effect."""

from __future__ import annotations

from pydub import AudioSegment, effects


def flashbacksceneengine(segment: AudioSegment, depth: float = 0.5) -> AudioSegment:
    """Return ``segment`` filtered with a simple "memory" effect."""

    depth = max(0.0, min(depth, 1.0))
    filtered = effects.low_pass_filter(segment, cutoff=1200)
    echo = filtered - (depth * 10)
    return filtered.overlay(echo, position=50)


__all__ = ["flashbacksceneengine"]
