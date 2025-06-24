"""Logic to ensure dialogue segments do not overlap."""

from __future__ import annotations

from typing import Iterable, List, Tuple


def detect_dialogue_overlap(segments: Iterable[Tuple[int, int]]) -> List[Tuple[int, int]]:
    """Return adjusted ``segments`` with overlaps removed.

    Parameters
    ----------
    segments:
        Iterable of ``(start_ms, end_ms)`` tuples sorted by ``start_ms``.
    """

    adjusted: List[Tuple[int, int]] = []
    current = 0
    for start, end in segments:
        start = max(start, current)
        end = max(start, end)
        adjusted.append((start, end))
        current = end
    return adjusted


__all__ = ["detect_dialogue_overlap"]
