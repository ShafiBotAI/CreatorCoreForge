# Auto-generated for Allow hidden timeline unlocks based on listener behavior
from typing import List


def allow_hidden_timeline(history: List[str], required_scenes: int) -> bool:
    """Return True if listener qualifies for hidden timeline unlock."""
    return len(history) >= required_scenes
