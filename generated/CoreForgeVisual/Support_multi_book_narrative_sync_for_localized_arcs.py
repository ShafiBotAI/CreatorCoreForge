# Auto-generated for Support multi-book narrative sync for localized arcs
from __future__ import annotations

from typing import Dict, List


def support_multi_book(books: Dict[str, List[str]]) -> Dict[str, List[str]]:
    """Merge scene arcs across multiple ``books`` keyed by language."""

    merged: Dict[str, List[str]] = {}
    for lang, arcs in books.items():
        for i, arc in enumerate(arcs):
            merged.setdefault(str(i), []).append(f"{lang}:{arc}")
    return merged
