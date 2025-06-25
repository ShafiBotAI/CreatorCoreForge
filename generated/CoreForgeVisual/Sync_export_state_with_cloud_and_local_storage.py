# Auto-generated for Sync export state with cloud and local storage
from typing import Dict


def sync_export_state(state: Dict[str, str], cloud: Dict[str, str]) -> Dict[str, str]:
    """Synchronize local and cloud export state dictionaries."""

    cloud.update(state)
    return cloud
