# Auto-generated for Visualize alternate emotional arcs using heatmap overlays
from typing import Dict, List


def visualize_alternate_emotional(arcs: Dict[str, List[int]]) -> Dict[str, List[float]]:
    """Normalize emotional intensity values for heatmap visualization."""

    heatmaps: Dict[str, List[float]] = {}
    for tag, values in arcs.items():
        if not values:
            heatmaps[tag] = []
            continue
        max_val = max(values)
        if max_val == 0:
            heatmaps[tag] = [0.0 for _ in values]
        else:
            heatmaps[tag] = [v / max_val for v in values]
    return heatmaps
