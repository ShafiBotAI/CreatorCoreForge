# Auto-generated for NeuralOptimizer
from __future__ import annotations

import numpy as np


def neuraloptimizer(values: list[float], alpha: float = 0.1) -> list[float]:
    """Return a simple exponentially weighted moving-average of ``values``."""
    if not values:
        return []
    smoothed = [values[0]]
    for v in values[1:]:
        smoothed.append(alpha * v + (1 - alpha) * smoothed[-1])
    return smoothed


__all__ = ["neuraloptimizer"]
