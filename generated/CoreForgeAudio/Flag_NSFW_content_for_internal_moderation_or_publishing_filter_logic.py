"""Detect NSFW content for moderation purposes."""

from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Iterable, List

DEFAULT_WORDS: List[str] = [
    "explicit",
    "naked",
    "sex",
    "erotic",
    "nsfw",
]

@dataclass
class DetectionResult:
    text: str
    flagged: bool
    matches: List[str]


class NSFWContentFlagger:
    """Simple rule-based NSFW detector.

    The detector uses a list of keyword patterns and can be extended with
    additional words or regular expressions. It is synchronous and has no
    external dependencies so it can run offline.
    """

    def __init__(self, words: Iterable[str] | None = None) -> None:
        patterns = [re.compile(rf"\b{re.escape(w)}\b", re.IGNORECASE) for w in (words or DEFAULT_WORDS)]
        self._patterns = patterns

    def scan(self, text: str) -> DetectionResult:
        """Return detection details for a text block."""
        matches: List[str] = []
        for pattern in self._patterns:
            found = pattern.findall(text)
            if found:
                matches.extend(found)
        return DetectionResult(text=text, flagged=bool(matches), matches=matches)

    def is_nsfw(self, text: str) -> bool:
        return self.scan(text).flagged
