# Auto-generated for Include thumbnail and cover art generation from key frames
from typing import List


def include_thumbnail_and(frames: List[str]) -> List[str]:
    """Return a list of generated thumbnail asset names.

    Parameters
    ----------
    frames : list of str
        Key frame identifiers or file paths.

    Returns
    -------
    list of str
        Thumbnail file names derived from the key frames.
    """

    return [f"{frame}_thumb.jpg" for frame in frames]
