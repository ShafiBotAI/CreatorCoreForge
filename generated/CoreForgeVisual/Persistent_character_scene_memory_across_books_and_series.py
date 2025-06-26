# Auto-generated for Persistent character/scene memory across books and series
"""Simple in-memory tracker for character scenes by book."""

from collections import defaultdict
from typing import Dict, List

_memory: Dict[str, List[str]] = defaultdict(list)


def persistent_character_scene(book: str, scene: str) -> List[str]:
    """Store ``scene`` under ``book`` and return the current scene list."""

    _memory[book].append(scene)
    return list(_memory[book])


def memory_snapshot() -> Dict[str, List[str]]:
    """Expose stored memory for tests."""

    return {k: list(v) for k, v in _memory.items()}


__all__ = ["persistent_character_scene", "memory_snapshot"]
