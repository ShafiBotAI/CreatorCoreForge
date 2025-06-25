# Auto-generated for Adaptive soundtrack and voice SFX per scene

def adaptive_soundtrack_and(scene_tone: str) -> str:
    """Return a soundtrack identifier based on scene tone."""
    tone_map = {
        "action": "sfx_action.mp3",
        "romance": "sfx_romance.mp3",
        "horror": "sfx_horror.mp3",
    }
    return tone_map.get(scene_tone.lower(), "sfx_default.mp3")
