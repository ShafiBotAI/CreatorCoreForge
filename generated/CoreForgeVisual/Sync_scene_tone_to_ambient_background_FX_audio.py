# Auto-generated for Sync scene tone to ambient background FX audio
def sync_scene_tone(tone: str) -> str:
    """Return an ambient FX identifier for the given tone."""

    mapping = {
        "happy": "birds_chirping",
        "sad": "rain",
        "tense": "heartbeat",
    }
    return mapping.get(tone.lower(), "default")
