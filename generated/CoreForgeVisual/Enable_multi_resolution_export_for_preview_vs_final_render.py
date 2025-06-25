# Auto-generated for Enable multi-resolution export for preview vs final render
from typing import List


def enable_multi_resolution(resolutions: List[str]) -> List[str]:
    """Return the ordered list of resolutions for export."""

    return sorted(set(resolutions))
