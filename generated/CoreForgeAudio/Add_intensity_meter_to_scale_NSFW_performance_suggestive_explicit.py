# Auto-generated for Add intensity meter to scale NSFW performance (suggestive → explicit)
import re
from typing import Iterable


EXPLICIT_WORDS = {
    "sex", "moan", "touch", "hard", "wet", "naked", "thrust", "spank", "whisper",
    "heat", "scream", "climax", "explicit",
}


def add_intensity_meter(script: Iterable[str]) -> int:
    """Return an integer 0-100 describing the explicitness level of ``script``.

    ``script`` can be an iterable of lines or a single multi-line string. The
    implementation counts occurrences of words listed in ``EXPLICIT_WORDS`` and
    maps the result to a value between ``0`` (no explicit content) and ``100``
    (extremely explicit). This is a simplistic heuristic used for UI previews.
    """

    if isinstance(script, str):
        text = script.lower()
    else:
        text = "\n".join(script).lower()

    matches = sum(len(re.findall(rf"\b{re.escape(word)}\b", text)) for word in EXPLICIT_WORDS)
    # Assume 5 matches equals full intensity for this simple example
    intensity = min(100, int((matches / 5) * 100))
    return intensity


__all__ = ["add_intensity_meter"]
