# Auto-generated for Portfolio and analytics dashboards
from __future__ import annotations

from typing import Iterable, Dict


def portfolio_and_analytics(values: Iterable[float]) -> Dict[str, float]:
    """Return basic portfolio analytics for ``values``."""

    total = sum(values)
    average = total / len(list(values)) if values else 0
    return {"value": total, "average": average}


__all__ = ["portfolio_and_analytics"]
