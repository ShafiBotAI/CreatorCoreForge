# Auto-generated for Detect idioms and replace with native-equivalent visual cues
from __future__ import annotations

from typing import Dict


IDIOM_MAP: Dict[str, str] = {
    "break a leg": "show good luck thumbs-up",
    "raining cats and dogs": "use heavy rain animation",
}


def detect_idioms_and(text: str, idiom_map: Dict[str, str] | None = None) -> str:
    """Replace idioms in ``text`` with visual cue placeholders.

    Parameters
    ----------
    text:
        Input sentence that may contain idioms.
    idiom_map:
        Optional custom mapping of idioms to replacement cues.
    """

    mapping = IDIOM_MAP if idiom_map is None else idiom_map
    result = text
    for idiom, cue in mapping.items():
        result = result.replace(idiom, f"[{cue}]")
    return result

