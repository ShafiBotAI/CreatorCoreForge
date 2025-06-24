"""Utility to toggle between two narrator identifiers."""

from __future__ import annotations


def dualnarratortoggle(current: str, narrator_a: str, narrator_b: str) -> str:
    """Return the alternate narrator given ``current``."""
    return narrator_b if current == narrator_a else narrator_a


__all__ = ["dualnarratortoggle"]
