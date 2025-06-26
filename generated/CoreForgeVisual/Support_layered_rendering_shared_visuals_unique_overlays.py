# Auto-generated for Support layered rendering (shared visuals + unique overlays)
from typing import List, Tuple


def support_layered_rendering(base_layers: List[str], overlays: List[str]) -> List[Tuple[str, str]]:
    """Combine shared visuals with per-scene overlay layers.

    The function pairs each base visual with a matching overlay if present. When
    the overlay list is shorter than the base visuals list, empty overlays are
    substituted.
    """

    combined: List[Tuple[str, str]] = []
    for index, base in enumerate(base_layers):
        overlay = overlays[index] if index < len(overlays) else ""
        combined.append((base, overlay))
    return combined
