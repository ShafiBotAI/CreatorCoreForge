# Auto-generated for Allow creators to preview all timeline outcomes in side-by-side mode
from typing import List


def allow_creators_to(timelines: List[List[str]]) -> List[tuple]:
    """Zip timelines together for side-by-side preview."""

    max_len = max(len(t) for t in timelines)
    result = []
    for i in range(max_len):
        frame = tuple(t[i] if i < len(t) else "" for t in timelines)
        result.append(frame)
    return result
