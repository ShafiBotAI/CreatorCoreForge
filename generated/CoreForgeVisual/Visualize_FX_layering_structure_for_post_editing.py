# Auto-generated for Visualize FX layering structure for post-editing
from typing import List


def visualize_fx_layering(layers: List[str]) -> str:
    """Return a simple text diagram of FX layers."""

    return " > ".join(layers)
