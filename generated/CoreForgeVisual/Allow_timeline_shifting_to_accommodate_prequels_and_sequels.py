# Auto-generated for Allow timeline shifting to accommodate prequels and sequels
from typing import List, Dict


def allow_timeline_shifting(timeline: List[Dict], shift: int) -> List[Dict]:
    """Return a new timeline shifted by ``shift`` steps.

    A positive ``shift`` inserts empty slots at the start, effectively
    allowing a prequel to appear before the original first scene. A negative
    ``shift`` trims items from the beginning, similar to moving scenes later
    to make room for sequels.
    """

    if shift == 0:
        return list(timeline)

    if shift > 0:
        return [{} for _ in range(shift)] + list(timeline)

    # shift < 0
    return list(timeline[abs(shift):])
