# Auto-generated for Build continuity checker across timelines for style cohesion
from typing import Dict, List


def build_continuity_checker(timelines: Dict[str, List[str]]) -> Dict[str, bool]:
    """Check that each timeline uses a consistent visual style."""

    results: Dict[str, bool] = {}
    for tag, styles in timelines.items():
        results[tag] = len(set(styles)) <= 1
    return results
