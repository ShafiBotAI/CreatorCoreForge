# Auto-generated for Allow real-time override of generated framing or pacing
from __future__ import annotations

from typing import Callable


def allow_real_time(current_value: float, adjust_func: Callable[[float], float]) -> float:
    """Apply ``adjust_func`` to ``current_value`` at runtime.

    This minimal helper enables interactive controls to override
    the automatically generated framing or pacing values.
    """

    return adjust_func(current_value)
