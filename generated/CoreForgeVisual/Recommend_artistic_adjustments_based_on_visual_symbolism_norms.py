# Auto-generated for Recommend artistic adjustments based on visual symbolism norms
from __future__ import annotations

from typing import Dict


VISUAL_SYMBOLISM: Dict[str, str] = {
    "hero": "use strong key light",
    "villain": "add high-contrast shadows",
}

def recommend_artistic_adjustments(archetype: str) -> str:
    """Return a lighting or framing suggestion based on ``archetype``.

    ``archetype`` can be any key from :data:`VISUAL_SYMBOLISM`. If the
    archetype is unknown, ``"standard lighting"`` is returned.
    """

    return VISUAL_SYMBOLISM.get(archetype, "standard lighting")


def register_symbolism(archetype: str, suggestion: str) -> None:
    """Register a new symbolism guideline."""

    VISUAL_SYMBOLISM[archetype] = suggestion
