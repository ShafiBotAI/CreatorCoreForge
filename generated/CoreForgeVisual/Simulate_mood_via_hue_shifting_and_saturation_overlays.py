# Auto-generated for Simulate mood via hue shifting and saturation overlays
from typing import Tuple


def simulate_mood_via(hue: float, saturation: float, shift: float = 0.1) -> Tuple[float, float]:
    """Return adjusted hue and saturation values.

    Parameters
    ----------
    hue : float
        Current hue value ``0-1``.
    saturation : float
        Current saturation ``0-1``.
    shift : float, optional
        Amount to shift the hue by. Saturation is slightly boosted by the same value.

    Returns
    -------
    tuple
        ``(hue, saturation)`` after adjustment.
    """

    hue = (hue + shift) % 1.0
    saturation = min(1.0, max(0.0, saturation + shift))
    return hue, saturation
