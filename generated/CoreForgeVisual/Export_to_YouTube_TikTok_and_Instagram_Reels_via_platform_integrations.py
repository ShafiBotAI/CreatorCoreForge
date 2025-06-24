# Auto-generated for Export to YouTube, TikTok, and Instagram Reels via platform integrations
from typing import List


def export_to_youtube(file_path: str, platforms: List[str]) -> List[str]:
    """Simulate export to the given social platforms.

    Parameters
    ----------
    file_path : str
        Path to the rendered video file.
    platforms : list of str
        Platforms to export to.

    Returns
    -------
    list of str
        Status messages per platform.
    """

    return [f"Exported {file_path} to {p}" for p in platforms]
