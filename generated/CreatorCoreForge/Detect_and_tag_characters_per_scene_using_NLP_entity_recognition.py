import re
from typing import List, Dict

def detect_and_tag(scenes: List[str]) -> Dict[int, List[str]]:
    """Detect and tag characters per scene using a naive regex-based approach."""
    character_map: Dict[int, List[str]] = {}
    pattern = re.compile(r"\b([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)\b")
    for idx, scene in enumerate(scenes):
        character_map[idx] = list({m.group(1) for m in pattern.finditer(scene)})
    return character_map
