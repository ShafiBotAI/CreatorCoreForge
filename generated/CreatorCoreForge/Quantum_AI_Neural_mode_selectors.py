# Auto-generated for Quantum AI/Neural mode selectors
"""Select between Quantum and Neural engine modes."""

from __future__ import annotations

import os


AVAILABLE_MODES = {"quantum", "neural"}


def select_mode(mode: str | None = None) -> str:
    """Return a validated engine mode."""
    chosen = mode or os.getenv("CCF_ENGINE_MODE", "neural")
    if chosen not in AVAILABLE_MODES:
        raise ValueError(f"Unsupported mode: {chosen}")
    return chosen


__all__ = ["select_mode", "AVAILABLE_MODES"]
