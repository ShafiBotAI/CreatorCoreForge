# Auto-generated for Creator/Admin dashboard: credits, usage, analytics
from __future__ import annotations

from dataclasses import dataclass
from typing import Dict


@dataclass
class VisualAdminDashboard:
    credits: int = 0
    rendered_minutes: int = 0

    def add_render_minutes(self, minutes: int) -> None:
        self.rendered_minutes += minutes

    def analytics(self) -> Dict[str, int]:
        return {"credits": self.credits, "rendered_minutes": self.rendered_minutes}


def creator_admin_dashboard() -> VisualAdminDashboard:
    """Return a :class:`VisualAdminDashboard` instance."""

    return VisualAdminDashboard()


__all__ = ["VisualAdminDashboard", "creator_admin_dashboard"]
