# Auto-generated for Offer predictive timeline generator based on character decisions
from typing import List


def offer_predictive_timeline(decisions: List[str]) -> List[str]:
    """Generate a naive future timeline from a list of decisions."""
    timeline = []
    for step, decision in enumerate(decisions, start=1):
        timeline.append(f"Step {step}: consequence of {decision}")
    return timeline
