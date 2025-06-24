# Auto-generated for Integrate cross-book story arc tracking (hero's journey, redemption, fall)
from typing import List, Dict


def integrate_cross_book(arcs: List[Dict[str, str]]) -> Dict[str, List[str]]:
    """Combine story arcs from multiple books into a unified view."""

    combined: Dict[str, List[str]] = {}
    for arc in arcs:
        character = arc.get("character")
        event = arc.get("event")
        combined.setdefault(character, []).append(event)

    return combined
