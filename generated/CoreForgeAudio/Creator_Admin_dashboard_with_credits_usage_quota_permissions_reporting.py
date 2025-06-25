# Auto-generated for Creator/Admin dashboard with credits, usage, quota, permissions, reporting
from __future__ import annotations

from dataclasses import dataclass


@dataclass
class AdminDashboard:
    credits: int = 0
    usage: int = 0
    quota: int = 0

    def add_usage(self, amount: int) -> None:
        self.usage += amount

    def remaining_quota(self) -> int:
        return max(self.quota - self.usage, 0)


def creator_admin_dashboard() -> AdminDashboard:
    """Create and return an :class:`AdminDashboard` instance."""

    return AdminDashboard()


__all__ = ["AdminDashboard", "creator_admin_dashboard"]
