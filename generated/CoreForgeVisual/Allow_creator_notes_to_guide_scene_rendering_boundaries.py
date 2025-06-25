# Auto-generated for Allow creator notes to guide scene rendering boundaries
from typing import Dict, List, Tuple


def allow_creator_notes(notes: Dict[str, str]) -> List[Tuple[str, str]]:
    """Parse creator notes into scene boundary tuples.

    Args:
        notes: Mapping of scene identifier to note text. Notes can include
            "start" and "end" markers in the form "start=00:00 end=00:10".

    Returns:
        List of ``(scene_id, range_string)`` describing the boundaries.
    """

    boundaries: List[Tuple[str, str]] = []
    for scene_id, text in notes.items():
        start, end = "0:00", ""
        for part in text.split():
            if part.startswith("start="):
                start = part.split("=", 1)[1]
            elif part.startswith("end="):
                end = part.split("=", 1)[1]
        if end:
            boundaries.append((scene_id, f"{start}-{end}"))
    return boundaries
