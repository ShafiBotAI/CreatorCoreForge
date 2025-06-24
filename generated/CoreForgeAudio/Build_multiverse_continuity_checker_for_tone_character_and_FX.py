# Auto-generated for Build multiverse continuity checker for tone, character, and FX
from typing import Dict, Any, List


def build_multiverse_continuity(scenes: List[Dict[str, Any]]) -> List[str]:
    """Return a list of continuity issues detected across scenes."""
    issues: List[str] = []
    last_state: Dict[str, Any] = {}
    for idx, scene in enumerate(scenes):
        for key, value in scene.items():
            if key in last_state and last_state[key] != value:
                issues.append(f"Scene {idx}: {key} mismatch")
            last_state[key] = value
    return issues
