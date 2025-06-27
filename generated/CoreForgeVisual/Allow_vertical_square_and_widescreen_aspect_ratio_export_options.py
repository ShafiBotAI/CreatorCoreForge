# Auto-generated for Allow vertical, square, and widescreen aspect ratio export options
from __future__ import annotations

from typing import Tuple


def allow_vertical_square(base_width: int, aspect: str = "16:9") -> Tuple[int, int]:
    """Return (width, height) pixels for the requested ``aspect`` ratio."""

    w, h = map(int, aspect.split(":"))
    height = int(base_width * h / w)
    return base_width, height
