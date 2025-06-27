# Auto-generated for TraitMemoryPersistence
"""Simple persistence layer for character trait memory."""

from __future__ import annotations

import json
from pathlib import Path


class TraitMemoryPersistence:
    """Store and retrieve persistent character traits."""

    FILE = Path(__file__).resolve().parent / "trait_memory.json"

    def __init__(self) -> None:
        self._data = self._load()

    def _load(self) -> dict:
        if self.FILE.exists():
            return json.loads(self.FILE.read_text())
        return {}

    def _save(self) -> None:
        self.FILE.write_text(json.dumps(self._data, indent=2))

    def record(self, character: str, trait: str, value: str) -> None:
        self._data.setdefault(character, {})[trait] = value
        self._save()

    def traits_for(self, character: str) -> dict:
        return self._data.get(character, {})


__all__ = ["TraitMemoryPersistence"]
