"""Map voice dynamics to music templates."""

from __future__ import annotations

from typing import List, Dict


def link_scene_based(dynamics: List[str], templates: List[str]) -> Dict[str, str]:
    """Return mapping of ``dynamics`` to ``templates`` by position."""

    return {
        dyn: templates[min(i, len(templates) - 1)]
        for i, dyn in enumerate(dynamics)
    }


__all__ = ["link_scene_based"]
