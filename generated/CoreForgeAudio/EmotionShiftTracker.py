class Shift:
    def __init__(self, from_emotion: str, to_emotion: str, delta: float):
        self.from_emotion = from_emotion
        self.to_emotion = to_emotion
        self.delta = delta


class EmotionShiftTracker:
    """Tracks transitions between emotions."""

    def __init__(self):
        self.shifts = []
        self.last_emotion = None
        self.last_intensity = 0.0

    def log(self, emotion: str, intensity: float):
        if self.last_emotion is not None:
            self.shifts.append(Shift(self.last_emotion, emotion, intensity - self.last_intensity))
        self.last_emotion = emotion
        self.last_intensity = intensity

    def reset(self):
        self.shifts.clear()
        self.last_emotion = None
        self.last_intensity = 0.0
