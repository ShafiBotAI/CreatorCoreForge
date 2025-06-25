# Auto-generated for Adapt framing techniques based on memory weight (e.g., past = faded, current = vivid)

def adapt_framing_techniques(weight: float) -> str:
    """Return a suggested framing label based on memory weight."""
    if weight < 0.3:
        return "flashback-faded"
    if weight < 0.7:
        return "neutral"
    return "present-vivid"
