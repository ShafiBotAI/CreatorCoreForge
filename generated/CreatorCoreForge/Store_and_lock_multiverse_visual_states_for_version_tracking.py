# Auto-generated for Store and lock multiverse visual states for version tracking
"""Utility to track and lock visual states for multiverse timelines."""

from typing import Dict, Any

_locked_states: Dict[str, Dict[str, Any]] = {}


def store_and_lock(state_id: str, data: Dict[str, Any]) -> None:
    """Persist a visual state and lock it to prevent modifications."""
    if state_id in _locked_states:
        raise ValueError(f"State '{state_id}' is already locked")
    _locked_states[state_id] = dict(data)


def get_state(state_id: str) -> Dict[str, Any]:
    """Retrieve a locked visual state."""
    return _locked_states.get(state_id, {})
