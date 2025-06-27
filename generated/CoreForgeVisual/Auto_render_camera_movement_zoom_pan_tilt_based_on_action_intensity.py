# Auto-generated for Auto-render camera movement (zoom, pan, tilt) based on action intensity
from __future__ import annotations

def auto_render_camera(intensity: float) -> str:
    """Return a camera movement suggestion based on ``intensity``."""

    if intensity > 0.8:
        return "zoom"
    if intensity > 0.5:
        return "pan"
    if intensity > 0.2:
        return "tilt"
    return "static"
