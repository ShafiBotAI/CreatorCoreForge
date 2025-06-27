# Auto-generated for AccentGenerator
"""Utilities for generating accent-specific variations of text."""

from __future__ import annotations

from .AccentSwitcher import AccentSwitcher


def accentgenerator(text: str, accent: str = "standard") -> str:
    """Return ``text`` transformed using ``accent`` rules.

    Parameters
    ----------
    text: str
        The phrase to transform.
    accent: str, optional
        Accent key supported by :class:`AccentSwitcher`. Defaults to ``standard``.
    """

    switcher = AccentSwitcher(accent)
    return switcher.transform(text)


__all__ = ["accentgenerator"]
