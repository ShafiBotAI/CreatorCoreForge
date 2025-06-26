# Auto-generated for Enable AI director mode to guide scene transitions across branches
from typing import Dict, List


def enable_ai_director(branches: Dict[str, List[str]]) -> List[str]:
    """Simple scene transition suggestion across branches."""

    transitions: List[str] = []
    if not branches:
        return transitions

    max_len = max(len(s) for s in branches.values())
    for i in range(max_len - 1):
        next_scenes = {seq[i + 1] for seq in branches.values() if i + 1 < len(seq)}
        if next_scenes:
            transitions.append(next_scenes.pop())
    return transitions
