"""Heuristics for determining scene pacing."""

from __future__ import annotations

from statistics import mean
from typing import Sequence


def auto_suggest_optimal(text: str, emotion_scores: Sequence[float]) -> str:
    """Return a pacing label based on ``text`` and ``emotion_scores``.

    Parameters
    ----------
    text:
        Scene text.
    emotion_scores:
        Sequence of emotion intensity values in ``0..1``.
    """

    complexity = len(text.split())
    avg_emotion = mean(emotion_scores) if emotion_scores else 0
    score = complexity * 0.5 + avg_emotion * 10

    if score > 120:
        return "slow"
    if score > 60:
        return "medium"
    return "fast"


__all__ = ["auto_suggest_optimal"]
