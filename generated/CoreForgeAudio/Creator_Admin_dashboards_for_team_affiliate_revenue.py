# Auto-generated for Creator/Admin dashboards for team, affiliate, revenue
from __future__ import annotations

from typing import Dict


def creator_admin_dashboards(team_rev: Dict[str, float], affiliate_rev: Dict[str, float]) -> Dict[str, float]:
    """Return combined revenue metrics for team and affiliates."""

    total_team = sum(team_rev.values())
    total_affiliate = sum(affiliate_rev.values())
    return {
        "team": total_team,
        "affiliate": total_affiliate,
        "total": total_team + total_affiliate,
    }


__all__ = ["creator_admin_dashboards"]
