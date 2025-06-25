# Auto-generated for Track subscription credits and export quota by user
_credits = {}


def track_subscription_credits(user: str, used: int) -> int:
    """Update and return remaining credits for a user."""

    remaining = _credits.get(user, 10) - used
    _credits[user] = remaining
    return remaining
