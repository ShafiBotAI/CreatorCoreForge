"""Utility for linking books together in a multiverse graph."""
from __future__ import annotations

from collections import defaultdict
from typing import Dict, List


class MultiverseBookLinker:
    """Manage relationships between books across universes."""

    def __init__(self) -> None:
        self._links: Dict[str, List[str]] = defaultdict(list)

    def link_books(self, book_id: str, related_id: str) -> None:
        """Link ``book_id`` to ``related_id`` bi-directionally."""
        if related_id not in self._links[book_id]:
            self._links[book_id].append(related_id)
        if book_id not in self._links[related_id]:
            self._links[related_id].append(book_id)

    def get_links(self, book_id: str) -> List[str]:
        """Return linked book IDs for ``book_id``."""
        return list(self._links.get(book_id, []))


__all__ = ["MultiverseBookLinker"]
