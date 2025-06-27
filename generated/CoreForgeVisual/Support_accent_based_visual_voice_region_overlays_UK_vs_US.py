# Auto-generated for Support accent-based visual/voice region overlays (UK vs US)
from __future__ import annotations

from pathlib import Path


OVERLAY_PATHS = {
    "UK": Path("overlays/uk_overlay.png"),
    "US": Path("overlays/us_overlay.png"),
}


def support_accent_based(region: str) -> Path:
    """Return the overlay image path for the given region."""

    region = region.upper()
    return OVERLAY_PATHS.get(region, OVERLAY_PATHS["US"])

