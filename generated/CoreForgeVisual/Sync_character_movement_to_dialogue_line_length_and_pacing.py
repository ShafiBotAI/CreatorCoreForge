# Auto-generated for Sync character movement to dialogue line length and pacing

def sync_character_movement(dialogue: str, duration: float) -> list[float]:
    """Return frame timestamps for character movement synced to dialogue."""
    if duration <= 0:
        raise ValueError("Duration must be positive")

    words = len(dialogue.split())
    interval = duration / max(words, 1)
    return [round(i * interval, 2) for i in range(words)]
