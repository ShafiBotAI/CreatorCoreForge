# Auto-generated for Multi-style rendering (anime, live, fantasy, etc.)
"""Simple adapter applying a style label to each frame."""

from typing import Iterable, List


def multi_style_rendering(style: str, frames: Iterable[str]) -> List[str]:
    """Prefix each frame with the chosen ``style`` name."""

    return [f"{style}:{frame}" for frame in frames]


__all__ = ["multi_style_rendering"]
