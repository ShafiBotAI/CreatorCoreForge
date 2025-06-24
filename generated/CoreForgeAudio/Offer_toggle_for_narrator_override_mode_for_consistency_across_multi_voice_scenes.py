"""Controls for narrator override mode."""

from __future__ import annotations

from typing import Dict, Any


def offer_toggle_for(settings: Dict[str, Any], enable: bool) -> Dict[str, Any]:
    """Return updated ``settings`` with narrator override mode toggled.

    Parameters
    ----------
    settings:
        Current configuration dictionary.
    enable:
        ``True`` to enable override mode, ``False`` to disable.
    """

    updated = dict(settings)
    updated["narrator_override"] = bool(enable)
    return updated


__all__ = ["offer_toggle_for"]
