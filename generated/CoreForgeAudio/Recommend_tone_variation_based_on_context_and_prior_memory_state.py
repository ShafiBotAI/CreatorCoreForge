# Auto-generated for Recommend tone variation based on context and prior memory state
from typing import Dict


def recommend_tone_variation(context: str, memory_state: Dict[str, str]) -> str:
    """Return a tone suggestion based on context and memory state."""

    if context in memory_state:
        return memory_state[context]

    keywords = {
        "battle": "intense",
        "romance": "warm",
        "mystery": "whisper",
    }

    for key, tone in keywords.items():
        if key in context.lower():
            return tone

    return "neutral"
