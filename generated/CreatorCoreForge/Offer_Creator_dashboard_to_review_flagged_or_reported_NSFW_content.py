# Auto-generated for Offer Creator dashboard to review flagged or reported NSFW content
from __future__ import annotations

from dataclasses import dataclass, field
from typing import List


@dataclass
class NsfwDashboard:
    flags: List[str] = field(default_factory=list)

    def flag(self, item: str) -> None:
        self.flags.append(item)

    def list_flags(self) -> List[str]:
        return list(self.flags)


def offer_creator_dashboard() -> NsfwDashboard:
    """Create and return an :class:`NsfwDashboard`."""

    return NsfwDashboard()


__all__ = ["NsfwDashboard", "offer_creator_dashboard"]
