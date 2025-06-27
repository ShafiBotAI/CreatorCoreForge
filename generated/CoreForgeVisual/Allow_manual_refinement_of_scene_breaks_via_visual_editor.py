# Auto-generated for Allow manual refinement of scene breaks via visual editor
from __future__ import annotations

from typing import List


def allow_manual_refinement(scenes: List[str], breaks: List[int]) -> List[str]:
    """Return scenes split at the provided break indices.

    ``breaks`` is expected to be sorted and contain indices within ``scenes``.
    The function returns a new list of scene strings representing the refined
    segments.
    """

    refined: List[str] = []
    last = 0
    for idx in sorted(breaks):
        refined.append(" ".join(scenes[last:idx]))
        last = idx
    refined.append(" ".join(scenes[last:]))
    return [r for r in refined if r]
