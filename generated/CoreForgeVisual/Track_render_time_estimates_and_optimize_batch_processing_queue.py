# Auto-generated for Track render time estimates and optimize batch processing queue
from typing import List
import statistics


def track_render_time(times: List[float]) -> float:
    """Return the average render time from a list of times."""

    return statistics.mean(times) if times else 0.0
