# Auto-generated for Provide multiverse context summaries for catching up mid-path
from typing import List


def provide_multiverse_context(events: List[str], max_events: int = 5) -> str:
    """Return a short summary of recent events in the listener's timeline."""
    slice_events = events[-max_events:]
    return " | ".join(slice_events)
