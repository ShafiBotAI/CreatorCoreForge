# Auto-generated for Assign unique costume layers per scene or timeline
from __future__ import annotations

from typing import Dict


_costume_layers: Dict[str, str] = {}


def assign_unique_costume(scene_id: str, costume_asset: str) -> None:
    """Associate ``costume_asset`` with ``scene_id``."""

    _costume_layers[scene_id] = costume_asset


def costume_for_scene(scene_id: str) -> str | None:
    """Retrieve the costume asset for ``scene_id``."""

    return _costume_layers.get(scene_id)
