from typing import List

def allow_manual_refinement(scenes: List[str], merge_index: int) -> List[str]:
    """Merge the scene at merge_index with the following scene."""
    if merge_index < 0 or merge_index >= len(scenes) - 1:
        return scenes
    merged = scenes[:merge_index] + [scenes[merge_index] + ' ' + scenes[merge_index + 1]]
    return merged + scenes[merge_index + 2:]
