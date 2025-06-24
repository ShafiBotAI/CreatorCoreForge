# Auto-generated for Identify high-impact moments and render with frame-by-frame detail
from typing import List


def identify_high_impact(timeline: List[float], threshold: float = 0.8) -> List[int]:
    """Return indexes of high-impact frames given intensity timeline."""

    return [idx for idx, intensity in enumerate(timeline) if intensity >= threshold]
