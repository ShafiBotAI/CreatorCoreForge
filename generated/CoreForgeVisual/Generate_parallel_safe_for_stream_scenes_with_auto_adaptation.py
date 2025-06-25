# Auto-generated for Generate parallel safe-for-stream scenes with auto-adaptation
from typing import Iterable, Tuple


def generate_parallel_safe(scenes: Iterable[str]) -> Tuple[list, list]:
    """Return a tuple of (nsfw_safe, original) scene lists.

    The safe version appends ``-safe`` to each scene identifier.
    """

    scenes = list(scenes)
    safe_scenes = [f"{s}-safe" for s in scenes]
    return safe_scenes, scenes
