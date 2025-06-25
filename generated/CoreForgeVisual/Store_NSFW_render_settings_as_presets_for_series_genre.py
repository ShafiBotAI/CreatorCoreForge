# Auto-generated for Store NSFW render settings as presets for series/genre
from typing import Dict


_NSFW_PRESETS: Dict[str, Dict[str, str]] = {}


def store_nsfw_render(series: str, preset: Dict[str, str]) -> None:
    """Store render settings for a series or genre."""

    _NSFW_PRESETS[series] = preset
