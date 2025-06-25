# Auto-generated for Build Creator dashboard to manage NSFW scene ratings per book
from __future__ import annotations

from typing import Dict


def build_creator_dashboard(ratings: Dict[str, int]) -> str:
    """Return simple HTML listing NSFW scene ``ratings``.

    Parameters
    ----------
    ratings:
        Mapping of scene identifiers to rating scores.
    """

    rows = "".join(
        f"<tr><td>{scene}</td><td>{score}</td></tr>" for scene, score in ratings.items()
    )
    return f"<table>{rows}</table>"


__all__ = ["build_creator_dashboard"]
