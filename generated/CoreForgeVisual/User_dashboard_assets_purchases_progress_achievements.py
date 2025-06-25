# Auto-generated for User dashboard: assets, purchases, progress, achievements
from __future__ import annotations

from dataclasses import dataclass, field
from typing import List


@dataclass
class UserDashboard:
    assets: List[str] = field(default_factory=list)
    purchases: List[str] = field(default_factory=list)
    progress: int = 0

    def add_asset(self, asset: str) -> None:
        self.assets.append(asset)

    def record_purchase(self, item: str) -> None:
        self.purchases.append(item)

    def advance_progress(self, amount: int) -> None:
        self.progress += amount


def user_dashboard_assets() -> UserDashboard:
    """Create and return a simple :class:`UserDashboard`."""

    return UserDashboard()


__all__ = ["UserDashboard", "user_dashboard_assets"]
