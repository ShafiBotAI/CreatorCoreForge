"""Simple voice approval workflow utilities."""

from __future__ import annotations
from dataclasses import dataclass, field
from typing import Dict, List

@dataclass
class VoiceSegment:
    id: str
    path: str
    approved: bool = False
    notes: List[str] = field(default_factory=list)


def approve_segment(segment: VoiceSegment, note: str | None = None) -> None:
    """Mark a voice segment as approved and store optional note."""
    segment.approved = True
    if note:
        segment.notes.append(note)


def reject_segment(segment: VoiceSegment, note: str | None = None) -> None:
    """Mark a voice segment as rejected and store optional note."""
    segment.approved = False
    if note:
        segment.notes.append(note)


def summary(segments: List[VoiceSegment]) -> Dict[str, int]:
    """Return count of approved and rejected segments."""
    approved = sum(1 for s in segments if s.approved)
    rejected = len(segments) - approved
    return {"approved": approved, "rejected": rejected}

__all__ = ["VoiceSegment", "approve_segment", "reject_segment", "summary"]
