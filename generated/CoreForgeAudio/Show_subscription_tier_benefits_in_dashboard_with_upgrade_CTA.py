# Auto-generated for Show subscription tier benefits in dashboard with upgrade CTA
from __future__ import annotations


def show_subscription_tier(tier: str, benefits: dict) -> str:
    """Return HTML describing ``tier`` benefits with an upgrade CTA."""

    lines = "".join(f"<li>{b}</li>" for b in benefits.get(tier, []))
    return f"<h2>{tier.title()} Benefits</h2><ul>{lines}</ul><button>Upgrade</button>"


__all__ = ["show_subscription_tier"]
