class EmotionPacingEditor:
    """Adjust pacing based on intensity."""

    def pace(self, text: str, intensity: float) -> str:
        if intensity > 0.8:
            return text.upper()
        if intensity < 0.3:
            return "... ".join(text.split())
        return text
