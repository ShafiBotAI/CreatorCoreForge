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


__all__ = ["flashbacksceneengine"]
