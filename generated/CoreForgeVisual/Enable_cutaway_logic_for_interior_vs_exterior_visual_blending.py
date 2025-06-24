# Auto-generated for Enable cutaway logic for interior vs exterior visual blending
from typing import Any, Dict


def enable_cutaway_logic(interior_frame: Any, exterior_frame: Any, ratio: float = 0.5) -> Dict[str, Any]:
    """Return a simple cutaway blend representation.

    Parameters
    ----------
    interior_frame : Any
        Data representing the interior frame.
    exterior_frame : Any
        Data representing the exterior frame.
    ratio : float, optional
        Blend ratio where ``0`` is all interior and ``1`` is all exterior.

    Returns
    -------
    dict
        A dictionary describing the blend for testing purposes.
    """

    ratio = max(0.0, min(1.0, ratio))
    return {"interior": interior_frame, "exterior": exterior_frame, "ratio": ratio}
