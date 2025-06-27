# Auto-generated for Allow creators to upload reference art or override generated visuals
from __future__ import annotations

from pathlib import Path
from typing import Dict


_reference_art: Dict[str, Path] = {}


def allow_creators_to(scene_id: str, art_path: str) -> None:
    """Register ``art_path`` as reference art for ``scene_id``.

    The path is stored in an in-memory dictionary so downstream
    renderers can replace generated visuals with user-provided art.
    """

    path = Path(art_path)
    if path.is_file():
        _reference_art[scene_id] = path


def reference_art(scene_id: str) -> Path | None:
    """Return the reference art for ``scene_id`` if provided."""

    return _reference_art.get(scene_id)
