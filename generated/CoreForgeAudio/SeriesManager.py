"""Simple helper to manage a series of books."""
from __future__ import annotations

from typing import List


class SeriesManager:
    """Store and retrieve book IDs for a series."""

    def __init__(self) -> None:
        self._books: List[str] = []

    def add_book(self, book_id: str) -> None:
        if book_id not in self._books:
            self._books.append(book_id)

    def list_books(self) -> List[str]:
        return list(self._books)

    def current(self) -> str | None:
        return self._books[-1] if self._books else None


__all__ = ["SeriesManager"]
