# Auto-generated for Fan engagement, live voting, interactive overlays
_votes: dict[str, int] = {}

def fan_engagement_live(option: str) -> None:
    """Record a vote for the given option."""
    _votes[option] = _votes.get(option, 0) + 1

def vote_results() -> dict[str, int]:
    """Return current vote counts."""
    return dict(_votes)
