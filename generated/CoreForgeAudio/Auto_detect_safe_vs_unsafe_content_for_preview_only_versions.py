"""Classify text as safe or unsafe for preview purposes."""

from __future__ import annotations

from typing import Iterable

from .Flag_NSFW_content_for_internal_moderation_or_publishing_filter_logic import NSFWContentFlagger


class PreviewContentDetector:
    """Uses NSFWContentFlagger to classify content."""

    def __init__(self, blacklist: Iterable[str] | None = None) -> None:
        self.flagger = NSFWContentFlagger(blacklist)

    def classify(self, text: str) -> str:
        """Return "safe" or "unsafe"."""
        return "unsafe" if self.flagger.is_nsfw(text) else "safe"
