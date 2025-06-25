# Auto-generated for Auto-generate subtitle tracks synced with voice and visuals
from typing import List, Tuple


def auto_generate_subtitle(lines: List[str], durations: List[float]) -> List[Tuple[float, float, str]]:
    """Generate simple subtitle tuples.

    Parameters
    ----------
    lines : list of str
        Subtitle text lines.
    durations : list of float
        Duration of each line in seconds.

    Returns
    -------
    list of tuple
        ``(start, end, text)`` entries for subtitles.
    """

    start = 0.0
    subs = []
    for text, dur in zip(lines, durations):
        end = start + max(dur, 0)
        subs.append((start, end, text))
        start = end
    return subs
