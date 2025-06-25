# Auto-generated for AdaptiveLearningEngine

class AdaptiveLearningEngine:
    """Simple engine that updates weights based on feedback."""

    def __init__(self):
        self.weights = {}

    def update(self, key: str, success: bool) -> None:
        current = self.weights.get(key, 0.0)
        self.weights[key] = current + (1.0 if success else -1.0)

    def ranking(self) -> list:
        return sorted(self.weights.items(), key=lambda x: -x[1])
