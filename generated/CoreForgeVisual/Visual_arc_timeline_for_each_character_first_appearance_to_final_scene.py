# Auto-generated for Visual arc timeline for each character (first appearance to final scene)
from typing import List, Dict


def visual_arc_timeline(events: List[Dict]) -> List[str]:
    """Return a chronological list of scene identifiers for a character."""

    return [e.get("scene_id", "") for e in sorted(events, key=lambda e: e.get("order", 0))]
