# Auto-generated for Highlight visual callbacks to past books/scenes in creator view
from typing import List


def highlight_visual_callbacks(history: List[str], current_scene: str) -> List[str]:
    """Return callbacks that match ``current_scene`` keywords."""

    return [h for h in history if any(word in h for word in current_scene.split())]
