# Auto-generated for Highlight visual identity conflicts for creator review (e.g., two similar characters)

from typing import List, Tuple

def highlight_visual_identity(characters: List[Tuple[str, str]]) -> List[Tuple[str, str]]:
    """Return pairs of character names that have identical appearances."""
    conflicts = []
    seen = {}
    for name, appearance in characters:
        if appearance in seen and seen[appearance] != name:
            conflicts.append((seen[appearance], name))
        else:
            seen[appearance] = name
    return conflicts
