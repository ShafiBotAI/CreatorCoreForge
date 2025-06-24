# Auto-generated for Support dynamic shadows and ambient occlusion for realism
from typing import List


def support_dynamic_shadows(light_positions: List[float], object_position: float) -> List[float]:
    """Compute simple shadow intensities based on positions.

    Parameters
    ----------
    light_positions : List[float]
        Positions of lights along a 1D axis.
    object_position : float
        Position of the object receiving the shadow.

    Returns
    -------
    List[float]
        Relative shadow intensity from each light ``0-1``.
    """

    intensities = []
    for pos in light_positions:
        distance = abs(object_position - pos)
        intensities.append(max(0.0, 1.0 - distance))
    return intensities
