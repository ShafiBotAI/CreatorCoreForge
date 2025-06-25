# Auto-generated for Apply scene tone validator to suggest safe/NSFW rating per visual sequence
from typing import Iterable, List


SAFE_WORDS = {"happy", "calm", "wholesome"}


def apply_scene_tone(tokens: Iterable[str]) -> str:
    """Return 'safe' if no NSFW tone detected else 'nsfw'."""

    for tok in tokens:
        if tok.lower() not in SAFE_WORDS:
            return "nsfw"
    return "safe"
