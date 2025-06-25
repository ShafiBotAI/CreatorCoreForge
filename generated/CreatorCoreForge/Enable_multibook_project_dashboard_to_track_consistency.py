# Auto-generated for Enable multibook project dashboard to track consistency
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Dict


@dataclass
class MultibookDashboard:
    books: Dict[str, int] = field(default_factory=dict)

    def add_book(self, book_id: str, chapters: int) -> None:
        self.books[book_id] = chapters

    def report(self) -> Dict[str, int]:
        return {"books": len(self.books), "chapters": sum(self.books.values())}


def enable_multibook_project() -> MultibookDashboard:
    """Create and return a :class:`MultibookDashboard`."""

    return MultibookDashboard()


__all__ = ["MultibookDashboard", "enable_multibook_project"]
