# Auto-generated for Adjust posture, facial expressions, and body language based on dialogue tone

def adjust_posture_facial(tone: str) -> dict:
    """Return simple posture and expression hints for a tone."""
    tone = tone.lower()
    if tone in {"angry", "aggressive"}:
        return {"posture": "tense", "expression": "frown"}
    if tone in {"sad", "melancholic"}:
        return {"posture": "slumped", "expression": "sad"}
    if tone in {"happy", "excited"}:
        return {"posture": "upright", "expression": "smile"}
    return {"posture": "neutral", "expression": "neutral"}
