# Auto-generated for Filter NSFW content in search, preview, and trailer modes
from typing import Iterable, List


def filter_nsfw_content(items: Iterable[dict]) -> List[dict]:
    """Remove items flagged as NSFW.

    Each item is expected to be a mapping with a boolean ``nsfw`` key.
    """

    return [item for item in items if not item.get("nsfw")]
