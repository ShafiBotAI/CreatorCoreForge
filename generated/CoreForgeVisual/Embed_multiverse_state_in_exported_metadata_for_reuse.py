# Auto-generated for Embed multiverse state in exported metadata for reuse
from typing import Dict, Any


def embed_multiverse_state(metadata: Dict[str, Any], state: Dict[str, Any]) -> Dict[str, Any]:
    """Embed multiverse state information into export metadata."""

    meta = metadata.copy()
    meta["multiverse"] = state
    return meta
