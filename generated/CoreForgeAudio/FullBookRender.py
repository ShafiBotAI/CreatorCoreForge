"""Combine chapter audio into a single book file."""
from __future__ import annotations

import os
from typing import Iterable

from pydub import AudioSegment


def full_book_render(chapters: Iterable[str], out_path: str, fmt: str = "wav") -> str:
    """Concatenate chapter audio files into ``out_path``.

    Parameters
    ----------
    chapters: Iterable[str]
        Paths to chapter audio files in order.
    out_path: str
        Destination file path.
    fmt: str
        Output format (default ``wav``).
    """
    combined = AudioSegment.empty()
    for path in chapters:
        combined += AudioSegment.from_file(path)
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    combined.export(out_path, format=fmt)
    return out_path


__all__ = ["full_book_render"]
