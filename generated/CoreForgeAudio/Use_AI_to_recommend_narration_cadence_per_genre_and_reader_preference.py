"""Simple cadence recommendation heuristics."""

from __future__ import annotations


GENRE_BASE_RATE = {
    "thriller": 1.2,
    "comedy": 1.1,
    "drama": 1.0,
    "fantasy": 0.95,
    "romance": 0.9,
}


def use_ai_to(genre: str, preference: float = 1.0) -> float:
    """Return playback rate multiplier for ``genre`` and user ``preference``."""

    base = GENRE_BASE_RATE.get(genre.lower(), 1.0)
    return base * max(preference, 0.1)


__all__ = ["use_ai_to"]
