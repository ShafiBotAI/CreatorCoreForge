# Auto-generated for Extract scene descriptions from footnotes or appendices if referenced
import re
from typing import Dict


def extract_scene_descriptions(main_text: str, footnotes_text: str) -> Dict[int, str]:
    """Return a mapping of referenced footnote numbers to their descriptions."""

    references = set(int(num) for num in re.findall(r"\[(\d+)\]", main_text))
    footnote_map: Dict[int, str] = {}

    for match in re.finditer(r"^(\d+)\.\s*(.+)$", footnotes_text, flags=re.MULTILINE):
        num = int(match.group(1))
        if num in references:
            footnote_map[num] = match.group(2).strip()

    return footnote_map
