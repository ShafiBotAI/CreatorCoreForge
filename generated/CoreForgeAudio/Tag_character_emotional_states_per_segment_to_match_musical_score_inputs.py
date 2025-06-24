"""Utilities for tagging segments with emotion labels."""

from __future__ import annotations

from typing import Iterable, List, Tuple


def tag_character_emotional(
    segments: Iterable[str], labels: Iterable[str]
) -> List[Tuple[str, str]]:
    """Pair ``segments`` with emotion ``labels``."""

    return list(zip(segments, labels))


__all__ = ["tag_character_emotional"]
