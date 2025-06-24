# Auto-generated for Render close-up, medium, or wide shots based on character’s narrative importance

SHOT_THRESHOLDS = {
    "close": 0.8,
    "medium": 0.5,
}

def render_close_up(importance: float) -> str:
    """Return recommended shot type based on ``importance`` (0-1)."""
    if importance >= SHOT_THRESHOLDS["close"]:
        return "close-up"
    if importance >= SHOT_THRESHOLDS["medium"]:
        return "medium"
    return "wide"
