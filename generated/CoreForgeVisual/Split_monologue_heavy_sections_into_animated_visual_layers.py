# Auto-generated for Split monologue-heavy sections into animated visual layers
import re
from typing import List


def split_monologue_heavy(text: str, threshold: int = 250) -> List[str]:
    """Split large monologue paragraphs into sentence-based visual layers."""

    layers: List[str] = []
    paragraphs = [p.strip() for p in text.split("\n\n") if p.strip()]

    sentence_re = re.compile(r"(?<=[.!?])\s+")

    for para in paragraphs:
        if len(para) > threshold:
            layers.extend(sentence_re.split(para))
        else:
            layers.append(para)

    return [layer.strip() for layer in layers if layer.strip()]
