# Auto-generated for Generate recap videos per timeline path for audience immersion
from typing import Dict, List


def generate_recap_videos(timelines: Dict[str, List[str]]) -> Dict[str, List[str]]:
    """Generate short recap sequences for each timeline path.

    Each recap contains the first, middle, and last scene identifiers from the
    timeline if available. This lightweight summary can later be stitched into a
    video montage by the rendering pipeline.
    """

    recaps: Dict[str, List[str]] = {}
    for tag, scenes in timelines.items():
        if not scenes:
            recaps[tag] = []
            continue
        middle = scenes[len(scenes) // 2] if len(scenes) > 2 else scenes[0]
        recaps[tag] = [scenes[0], middle, scenes[-1]]
    return recaps
