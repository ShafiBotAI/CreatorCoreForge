# Auto-generated for Recommend background reuse based on memory location detection
from typing import Dict


def recommend_background_reuse(memory: Dict[str, str], location_id: str) -> str:
    """Return the last background used for ``location_id`` if available."""

    return memory.get(location_id, "")
