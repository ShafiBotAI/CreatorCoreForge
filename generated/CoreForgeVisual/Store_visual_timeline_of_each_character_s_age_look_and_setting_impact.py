# Auto-generated for Store visual timeline of each character’s age, look, and setting impact
from typing import Dict, List

_timeline: Dict[str, List[str]] = {}


def store_visual_timeline(character: str, entry: str) -> None:
    """Append a timeline entry for a character."""

    _timeline.setdefault(character, []).append(entry)


def get_visual_timeline(character: str) -> List[str]:
    """Return timeline entries for a character."""

    return _timeline.get(character, [])
