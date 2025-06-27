"""Heuristically detect chapter boundaries with manual fallback."""
from __future__ import annotations
from typing import List


def auto_detect_chapter(text: str) -> List[int]:
    """Return line indices that likely mark chapter starts."""
    lines = text.splitlines()
    indices: List[int] = []
    for idx, line in enumerate(lines):
        normalized = line.strip().lower()
        if normalized.startswith("chapter ") or normalized.startswith("# chapter"):
            indices.append(idx)
    # Fallback: treat blank lines followed by text as potential break
    if not indices:
        for idx in range(1, len(lines)):
            if lines[idx - 1].strip() == "" and lines[idx].strip():
                indices.append(idx)
    return indices

__all__ = ["auto_detect_chapter"]
