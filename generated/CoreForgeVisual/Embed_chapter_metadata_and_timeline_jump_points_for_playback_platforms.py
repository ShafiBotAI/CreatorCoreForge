# Auto-generated for Embed chapter metadata and timeline jump points for playback platforms
from typing import Dict, List


def embed_chapter_metadata(metadata: Dict[str, str], chapters: List[int]) -> Dict[str, List[int]]:
    """Embed chapter metadata with jump points for playback.

    Parameters
    ----------
    metadata : dict
        Arbitrary metadata for the book or video.
    chapters : list of int
        Chapter start offsets in seconds.

    Returns
    -------
    dict
        Combined metadata including jump points.
    """

    result = dict(metadata)
    result["jumps"] = chapters
    return result
