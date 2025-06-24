# Auto-generated for Display visual multiverse map with branches and connections
from typing import Dict, List


def display_visual_multiverse(branches: Dict[str, List[str]]) -> List[str]:
    """Return a flattened representation of the multiverse map."""

    output = []
    for branch, scenes in branches.items():
        output.append(f"{branch}:{len(scenes)}")
    return output
