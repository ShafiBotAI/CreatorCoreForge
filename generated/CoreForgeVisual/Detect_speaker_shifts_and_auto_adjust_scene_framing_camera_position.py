# Auto-generated for Detect speaker shifts and auto-adjust scene framing/camera position

from typing import List, Tuple

def detect_speaker_shifts(script: List[Tuple[str, str]]) -> List[int]:
    """Return indices in ``script`` where the speaker changes."""
    shifts = []
    last_speaker = None
    for i, (speaker, _) in enumerate(script):
        if last_speaker is not None and speaker != last_speaker:
            shifts.append(i)
        last_speaker = speaker
    return shifts
