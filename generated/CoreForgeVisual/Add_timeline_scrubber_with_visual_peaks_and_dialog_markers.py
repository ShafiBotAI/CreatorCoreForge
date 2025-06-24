# Auto-generated for Add timeline scrubber with visual peaks and dialog markers

def add_timeline_scrubber(peaks: list, dialog_times: list) -> list:
    """Merge peaks and dialog markers into a sorted timeline."""
    markers = [(t, "peak") for t in peaks] + [(t, "dialog") for t in dialog_times]
    return [m for m in sorted(markers, key=lambda x: x[0])]
