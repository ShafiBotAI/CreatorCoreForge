"""Plot simple emotion curves using matplotlib."""
from __future__ import annotations

from typing import Iterable
import matplotlib.pyplot as plt


def emotioncurvevisualizer(values: Iterable[float]):
    """Return a matplotlib figure showing ``values`` over time."""
    fig, ax = plt.subplots()
    ax.plot(list(values))
    ax.set_xlabel("Index")
    ax.set_ylabel("Intensity")
    ax.set_title("Emotion Curve")
    return fig


__all__ = ["emotioncurvevisualizer"]
