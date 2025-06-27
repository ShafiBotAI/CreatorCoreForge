# Auto-generated for Sync memory state and emotional arc history between devices
"""Synchronize memory state and emotional arc history between devices."""

from __future__ import annotations

import json
from pathlib import Path


class MemorySync:
    """Handle save/load of memory state across devices."""

    FILE = Path.home() / ".coreforge_memory_sync.json"

    def __init__(self) -> None:
        self.state = self._load()

    def _load(self) -> dict:
        if self.FILE.exists():
            return json.loads(self.FILE.read_text())
        return {}

    def push(self, book_id: str, state: dict) -> None:
        self.state[book_id] = state
        self.FILE.write_text(json.dumps(self.state, indent=2))

    def pull(self, book_id: str) -> dict:
        return self.state.get(book_id, {})


__all__ = ["MemorySync"]
