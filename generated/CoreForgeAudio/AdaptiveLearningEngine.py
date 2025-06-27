# Auto-generated for AdaptiveLearningEngine
"""Lightweight adaptive learning tracker used for tutorials."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Dict, Optional
import time


@dataclass
class AdaptiveLearningEngine:
    """Track lesson completions and topic scores."""

    topic_scores: Dict[str, int] = field(default_factory=dict)
    progress: Dict[str, int] = field(default_factory=dict)
    last_completion: Dict[str, float] = field(default_factory=dict)

    def record(self, topic: str, score: int) -> None:
        """Record a score for ``topic``."""
        self.topic_scores[topic] = score

    def next_topic(self) -> Optional[str]:
        """Return the topic with the lowest score, if any."""
        if not self.topic_scores:
            return None
        return min(self.topic_scores, key=self.topic_scores.get)

    def record_completion(self, lesson: str) -> None:
        """Track that ``lesson`` was completed."""
        self.progress[lesson] = self.progress.get(lesson, 0) + 1
        self.last_completion[lesson] = time.time()

    def completion_count(self, lesson: str) -> int:
        return self.progress.get(lesson, 0)

    def last_completion_date(self, lesson: str) -> float | None:
        return self.last_completion.get(lesson)

    def reset(self) -> None:
        self.topic_scores.clear()
        self.progress.clear()
        self.last_completion.clear()


__all__ = ["AdaptiveLearningEngine"]
