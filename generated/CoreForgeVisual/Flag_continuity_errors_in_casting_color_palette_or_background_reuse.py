# Auto-generated for Flag continuity errors in casting, color palette, or background reuse
from typing import List, Tuple


def flag_continuity_errors(scenes: List[Tuple[str, str]]) -> List[int]:
    """Return indices where consecutive scenes reuse the same background."""

    errors = []
    for i in range(1, len(scenes)):
        if scenes[i][1] == scenes[i - 1][1]:
            errors.append(i)
    return errors
