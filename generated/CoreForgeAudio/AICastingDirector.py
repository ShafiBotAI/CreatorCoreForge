# Auto-generated for AICastingDirector
from __future__ import annotations

import random
from typing import List


class AICastingDirector:
    """Assigns an AI voice actor to a character name."""

    def __init__(self, actors: List[str] | None = None) -> None:
        self.actors = actors or [
            "Enthusiastic Actor",
            "Mellow Narrator",
            "Dramatic Performer",
        ]

    def cast(self, character: str) -> str:
        """Return a deterministic actor name for the given character."""
        random.seed(character)
        return random.choice(self.actors)


__all__ = ["AICastingDirector"]
