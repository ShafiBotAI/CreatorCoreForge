# Auto-generated for Link voice performance timing with facial movement and lip sync

from typing import List, Tuple

def link_voice_performance(durations: List[float], text: str) -> List[Tuple[float, str]]:
    """Map word timings to durations for simple lip-sync scheduling."""
    words = text.split()
    if not words or not durations:
        return []

    interval = durations[-1] / len(words)
    return [(round(i * interval, 2), word) for i, word in enumerate(words)]
