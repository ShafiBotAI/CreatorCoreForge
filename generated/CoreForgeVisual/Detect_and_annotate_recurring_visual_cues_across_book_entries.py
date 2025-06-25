# Auto-generated for Detect and annotate recurring visual cues across book entries
from typing import List, Dict


def detect_and_annotate(entries: List[Dict]) -> Dict[str, int]:
    """Return a frequency map of visual cues across ``entries``."""

    freq: Dict[str, int] = {}
    for entry in entries:
        for cue in entry.get("cues", []):
            freq[cue] = freq.get(cue, 0) + 1
    return freq
