# Auto-generated for Sync exported files across devices with user authentication
from typing import Dict, List


def sync_exported_files(files: List[str], devices: Dict[str, List[str]]) -> Dict[str, List[str]]:
    """Associate exported files with each authenticated device."""

    for d in devices:
        devices[d].extend(files)
    return devices
