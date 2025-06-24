"""HTML dashboard generator for voice metrics."""

from __future__ import annotations

from typing import Dict


def build_creator_dashboard(metrics: Dict[str, float]) -> str:
    """Return a simple HTML table for ``metrics``."""

    rows = "".join(
        f"<tr><td>{k}</td><td>{v:.2f}</td></tr>" for k, v in metrics.items()
    )
    return f"<table>{rows}</table>"


__all__ = ["build_creator_dashboard"]
