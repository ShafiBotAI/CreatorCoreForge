# Auto-generated for Tag series-specific visual themes (e.g., "gold light = safety")
from typing import Dict


def tag_series_specific(theme_tags: Dict[str, str], scene_tag: str) -> str:
    """Return the visual theme for ``scene_tag`` from ``theme_tags``."""

    return theme_tags.get(scene_tag, "default")
