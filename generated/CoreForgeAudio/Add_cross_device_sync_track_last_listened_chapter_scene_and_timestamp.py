# Auto-generated for Add cross-device sync: track last listened chapter, scene, and timestamp
"""Simple JSON-based cross-device sync helpers."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Dict, Optional


DEFAULT_SYNC_FILE = Path.home() / ".coreforge_sync.json"


def update_position(
    book_id: str,
    chapter: int,
    scene: int,
    timestamp: float,
    file_path: Path = DEFAULT_SYNC_FILE,
) -> None:
    """Store the latest position for ``book_id`` in ``file_path``."""

    data = _load_sync(file_path)
    data[book_id] = {
        "chapter": chapter,
        "scene": scene,
        "timestamp": timestamp,
    }
    _save_sync(file_path, data)


def load_position(book_id: str, file_path: Path = DEFAULT_SYNC_FILE) -> Optional[Dict[str, float]]:
    """Return the last stored position for ``book_id`` if available."""

    data = _load_sync(file_path)
    return data.get(book_id)


def _load_sync(file_path: Path) -> Dict[str, Dict[str, float]]:
    if file_path.is_file():
        with open(file_path, "r", encoding="utf-8") as f:
            try:
                return json.load(f)
            except json.JSONDecodeError:
                return {}
    return {}


def _save_sync(file_path: Path, data: Dict[str, Dict[str, float]]) -> None:
    file_path.parent.mkdir(parents=True, exist_ok=True)
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(data, f)


__all__ = ["update_position", "load_position"]
