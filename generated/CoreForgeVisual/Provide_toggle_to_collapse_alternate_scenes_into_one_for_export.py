# Auto-generated for Provide toggle to collapse alternate scenes into one for export
from typing import List


def collapse_scenes(scenes: List[str], collapse: bool) -> List[str]:
    """Return collapsed scene list depending on toggle."""
    if not collapse:
        return scenes
    combined = ["\n".join(scenes)] if scenes else []
    return combined
