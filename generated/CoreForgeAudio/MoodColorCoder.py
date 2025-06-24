"""Map mood names to simple hex color codes."""
from __future__ import annotations


def moodcolorcoder(mood: str) -> str:
    mapping = {
        "tense": "#ff0000",
        "romantic": "#ff69b4",
        "peaceful": "#00ffcc",
        "suspenseful": "#ffa500",
    }
    return mapping.get(mood.lower(), "#ffffff")


__all__ = ["moodcolorcoder"]
