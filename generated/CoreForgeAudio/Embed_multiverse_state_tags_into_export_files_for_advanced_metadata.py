# Auto-generated for Embed multiverse state tags into export files for advanced metadata
from typing import Dict


def embed_multiverse_state(metadata: Dict[str, str], timeline: str) -> Dict[str, str]:
    """Return updated metadata dictionary with multiverse state."""
    meta = dict(metadata)
    meta["multiverse_state"] = timeline
    return meta
