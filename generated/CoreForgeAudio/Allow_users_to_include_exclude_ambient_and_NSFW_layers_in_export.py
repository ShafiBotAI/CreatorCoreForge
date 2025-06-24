# Auto-generated for Allow users to include/exclude ambient and NSFW layers in export
from typing import List


def allow_users_to(layers: List[str], include_nsfw: bool) -> List[str]:
    """Return final layer list based on user preference."""
    filtered = [l for l in layers if include_nsfw or "nsfw" not in l.lower()]
    return filtered
