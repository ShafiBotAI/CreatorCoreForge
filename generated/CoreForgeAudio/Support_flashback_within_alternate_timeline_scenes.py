# Auto-generated for Support flashback-within-alternate-timeline scenes
from typing import List


def support_flashback_within(scenes: List[str], flashback_marker: str = "FLASHBACK") -> List[str]:
    """Insert flashback markers for alternate timeline scenes."""
    return [f"{flashback_marker}:{s}" for s in scenes]
