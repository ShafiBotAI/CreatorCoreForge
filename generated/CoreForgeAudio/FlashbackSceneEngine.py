
"""Engine utilities for marking flashback scenes."""

from __future__ import annotations
from typing import Iterable, List, Tuple


def flashbacksceneengine(
    scenes: Iterable[str], flashback_indices: Iterable[int]
) -> List[Tuple[str, bool]]:
    """Return ``scenes`` paired with a boolean flag for flashback scenes."""
    indices = set(flashback_indices)
    result: List[Tuple[str, bool]] = []
    for idx, scene in enumerate(scenes):
        result.append((scene, idx in indices))
    return result
=======
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
