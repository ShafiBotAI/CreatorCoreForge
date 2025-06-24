# Auto-generated for Highlight inconsistencies in voice delivery across books for correction
from typing import List, Tuple


def highlight_inconsistencies_in(deliveries: List[Tuple[str, float]]) -> List[str]:
    """Return chapters where voice delivery varies greatly between books."""
    out: List[str] = []
    if not deliveries:
        return out
    avg = sum(d[1] for d in deliveries) / len(deliveries)
    for chapter, value in deliveries:
        if abs(value - avg) > 0.5:
            out.append(chapter)
    return out
