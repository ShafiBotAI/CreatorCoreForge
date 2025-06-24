# Auto-generated for Support 16:9, vertical, and square rendering formats
from typing import Tuple


def support_vertical_and(width: int, height: int) -> Tuple[int, int]:
    """Adjust dimensions to the closest supported aspect ratio."""

    ratios = {(16, 9), (9, 16), (1, 1)}
    for rw, rh in ratios:
        if width * rh == height * rw:
            return width, height

    # fallback to 16:9 while preserving height
    new_width = int(height * 16 / 9)
    return new_width, height
