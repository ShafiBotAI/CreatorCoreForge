"""Utility for creating modified copies of voice DNA profiles."""

from __future__ import annotations
from typing import Dict, Any


def voicednaforking(
    base: Dict[str, Any], overrides: Dict[str, Any] | None = None
) -> Dict[str, Any]:
    """Return a new voice DNA based on ``base`` with ``overrides`` applied."""
    new_dna = base.copy()
    if overrides:
        new_dna.update(overrides)
    return new_dna


__all__ = ["voicednaforking"]
