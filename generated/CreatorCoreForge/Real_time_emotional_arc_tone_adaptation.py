# Auto-generated for Real-time emotional arc & tone adaptation
from __future__ import annotations
import re

POSITIVE_WORDS = {"good", "great", "happy", "excited", "love", "excellent", "positive"}
NEGATIVE_WORDS = {"bad", "sad", "angry", "hate", "terrible", "negative"}


def real_time_emotional(text: str) -> float:
    """Return a simple sentiment score for the given text."""
    tokens = re.findall(r"[a-zA-Z]+", text.lower())
    pos = sum(1 for t in tokens if t in POSITIVE_WORDS)
    neg = sum(1 for t in tokens if t in NEGATIVE_WORDS)
    if not tokens:
        return 0.0
    return (pos - neg) / len(tokens)
