# Auto-generated for Cross-link tone history with voice fingerprint DNA across the series
from typing import Dict, List


def cross_link_tone(history: Dict[str, List[str]]) -> Dict[str, List[str]]:
    """Cross-link tone history across a series by voice fingerprint."""

    linked: Dict[str, List[str]] = {}
    for voice_id, tones in history.items():
        linked[voice_id] = list(dict.fromkeys(tones))

    return linked
