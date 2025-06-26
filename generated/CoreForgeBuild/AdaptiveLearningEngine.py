# Auto-generated for AdaptiveLearningEngine
"""Simplified adaptive progress tracker."""

class AdaptiveLearningEngine:
    def __init__(self) -> None:
        self._scores: dict[str, int] = {}

    def record_score(self, topic: str, score: int) -> None:
        self._scores[topic] = score

    def next_topic(self) -> str | None:
        if not self._scores:
            return None
        return min(self._scores, key=self._scores.get)

    def reset(self) -> None:
        self._scores.clear()


__all__ = ["AdaptiveLearningEngine"]
