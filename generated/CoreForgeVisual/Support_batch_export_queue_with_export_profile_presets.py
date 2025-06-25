# Auto-generated for Support batch export queue with export profile presets
from collections import deque
from typing import Any, Deque


def support_batch_export(items: Deque[Any]) -> int:
    """Process a batch export queue and return number of items processed."""

    count = 0
    while items:
        items.popleft()
        count += 1
    return count
