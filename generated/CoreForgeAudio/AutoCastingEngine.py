class VoiceProfile:
    def __init__(self, name: str, emotion: str):
        self.name = name
        self.emotion = emotion


class AutoCastingEngine:
    """Suggests simple voice profiles."""

    def suggest_voice(self, genre: str, tone: str) -> VoiceProfile:
        name = f"{genre.capitalize()} {tone.capitalize()}"
        return VoiceProfile(name, tone.lower())

    def suggested_voice(self, genre: str) -> VoiceProfile:
        if "horror" in genre.lower():
            return VoiceProfile("Spooky", "tense")
        return VoiceProfile("Narrator", "neutral")
