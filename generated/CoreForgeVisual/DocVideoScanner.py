"""Document and video frame scanning utilities."""
from typing import List, Dict


class DocVideoScanner:
    """Scans documents and video frames for keyword occurrences."""

    def scan_document(self, text: str, keywords: List[str]) -> Dict[str, int]:
        counts: Dict[str, int] = {}
        lower = text.lower()
        for key in keywords:
            k = key.lower()
            c = lower.count(k)
            if c > 0:
                counts[key] = c
        return counts

    def scan_video_frames(self, frames: List[str], tag: str) -> int:
        return sum(1 for frame in frames if tag in frame)
