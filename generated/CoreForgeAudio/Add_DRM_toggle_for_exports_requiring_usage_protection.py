# Auto-generated for Add DRM toggle for exports requiring usage protection
"""Utilities for marking exports with a DRM flag."""

from __future__ import annotations

from typing import Dict


def apply_drm(metadata: Dict[str, str], enable: bool = True) -> Dict[str, str]:
    """Return a copy of ``metadata`` updated with a DRM flag."""

    meta = dict(metadata)
    meta["drm_protected"] = "true" if enable else "false"
    return meta


__all__ = ["apply_drm"]
