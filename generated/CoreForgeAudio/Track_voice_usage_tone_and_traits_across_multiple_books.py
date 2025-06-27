# Auto-generated for Track voice usage, tone, and traits across multiple books
"""Utilities for tracking voice usage statistics across books."""

from __future__ import annotations


class VoiceUsageTracker:
    def __init__(self) -> None:
        self.records: dict[str, list[dict]] = {}

    def record(self, book_id: str, character: str, tone: str) -> None:
        self.records.setdefault(book_id, []).append({
            "character": character,
            "tone": tone,
        })

    def report(self, book_id: str) -> list[dict]:
        return self.records.get(book_id, [])


__all__ = ["VoiceUsageTracker"]
