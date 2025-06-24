# Auto-generated for Identify group scenes and auto-generate spatial layouts

from typing import List, Tuple

def identify_group_scenes(characters: List[str]) -> Tuple[bool, List[Tuple[str, float]]]:
    """Return whether the scene is a group scene and a simple circular layout."""
    is_group = len(characters) > 2
    angle_step = 360 / max(len(characters), 1)
    layout = [(char, round(i * angle_step, 2)) for i, char in enumerate(characters)]
    return is_group, layout
