"""Scene-specific mastering preset generator."""

from __future__ import annotations

from typing import Dict


def enable_creator_ai(scene: str) -> Dict[str, float]:
    """Return simple mastering preset values based on ``scene`` keywords."""

    scene_lower = scene.lower()
    if "action" in scene_lower:
        return {"eq_low": -2.0, "compress": 3.0}
    if "romance" in scene_lower:
        return {"eq_high": 1.5, "compress": 1.0}
    return {"eq_low": 0.0, "compress": 2.0}


__all__ = ["enable_creator_ai"]
