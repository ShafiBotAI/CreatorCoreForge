# Auto-generated for Allow experimental rendering mode with parallel timeline mix
from typing import List


def allow_experimental_rendering(tracks: List[str]) -> List[str]:
    """Return a mixed list representing parallel timeline audio."""
    return [f"mix:{t}" for t in tracks]
