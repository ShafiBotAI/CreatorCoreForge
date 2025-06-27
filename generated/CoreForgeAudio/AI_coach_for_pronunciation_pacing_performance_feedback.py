# Auto-generated for AI “coach” for pronunciation, pacing, performance feedback
"""Utility helpers for basic speech performance analysis."""

from __future__ import annotations

import re
import statistics
from typing import Dict


def analyze_speech(transcript: str, duration_seconds: float) -> Dict[str, float | str]:
    """Return simple pacing metrics and feedback.

    Parameters
    ----------
    transcript: str
        Full transcript of the spoken audio.
    duration_seconds: float
        Length of the audio in seconds.

    Returns
    -------
    dict
        A dictionary containing ``wpm`` and ``avg_word_length`` plus a feedback
        string suggesting pacing adjustments.
    """

    words = re.findall(r"\b\w+\b", transcript)
    if duration_seconds > 0:
        wpm = len(words) / (duration_seconds / 60)
    else:
        wpm = 0.0

    avg_word_length = statistics.mean(len(w) for w in words) if words else 0.0

    feedback_parts: list[str] = []
    if wpm < 120:
        feedback_parts.append("Consider speaking faster.")
    elif wpm > 190:
        feedback_parts.append("Consider slowing down.")

    feedback = " ".join(feedback_parts)

    return {"wpm": wpm, "avg_word_length": avg_word_length, "feedback": feedback}


__all__ = ["analyze_speech"]
