# Auto-generated for Match voiceover tone with cultural delivery style (e.g., reserved vs expressive)
def match_voiceover_tone(tone: str) -> str:
    """Map neutral tone descriptors to cultural styles."""
    return "expressive" if tone.lower() in {"excited", "dramatic"} else "reserved"
