# Auto-generated for Embed NSFW warning overlays for early scene detection
from typing import List


def embed_nsfw_warning(frames: List[str]) -> List[str]:
    """Embed a simple NSFW overlay onto video frames.

    Each returned frame is suffixed with ``-nsfw-warning`` to indicate the
    overlay has been applied.
    """

    return [f"{frame}-nsfw-warning" for frame in frames]
