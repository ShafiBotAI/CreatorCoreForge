# Auto-generated for Auto-detect chapter breaks and scene transitions using AI
from __future__ import annotations

from typing import List


def auto_detect_chapter(text: str) -> List[int]:
    """Return indices of lines that likely begin new chapters."""

    lines = text.splitlines()
    indices = []
    for idx, line in enumerate(lines):
        if line.strip().lower().startswith("chapter "):
            indices.append(idx)
    return indices
