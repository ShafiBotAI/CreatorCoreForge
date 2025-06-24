# Auto-generated for Store original book structure for syncing narration with visuals
import re
from typing import List, Dict


def store_original_book(text: str) -> List[Dict[str, str]]:
    """Parse a book's raw text and return a structured chapter map."""

    chapters: List[Dict[str, str]] = []
    current_title = "Prologue"
    buffer: List[str] = []

    chapter_pattern = re.compile(r"^(?:chapter|CHAPTER)\s+\d+", re.IGNORECASE)

    for line in text.splitlines():
        if chapter_pattern.match(line.strip()):
            if buffer:
                chapters.append({"title": current_title, "content": "\n".join(buffer).strip()})
                buffer = []
            current_title = line.strip()
        else:
            buffer.append(line)

    if buffer:
        chapters.append({"title": current_title, "content": "\n".join(buffer).strip()})

    return chapters
