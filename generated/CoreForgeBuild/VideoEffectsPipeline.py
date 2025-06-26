# Auto-generated for VideoEffectsPipeline
"""Utility helpers for video frame manipulation."""

from dataclasses import dataclass
from typing import List


@dataclass
class RenderedClip:
    frames: List[str]


class VideoEffectsPipeline:
    def apply_fade_transitions(self, frames: List[str]) -> List[str]:
        result: List[str] = []
        for i, f in enumerate(frames):
            result.append(f)
            if i < len(frames) - 1:
                result.append("fade")
        return result

    def add_watermark(self, frames: List[str], watermark: str) -> List[str]:
        return [f"{f}-{watermark}" for f in frames]

    def apply_fade_in_out(self, frames: List[str]) -> List[str]:
        if not frames:
            return []
        return ["fade-in", *frames, "fade-out"]

    def compose_video(self, frames: List[str], audio: str) -> RenderedClip:
        tagged = [f"{f}|audio:{audio}" for f in frames]
        return RenderedClip(frames=tagged)

    def interpolate_frames(self, frames: List[str]) -> List[str]:
        if len(frames) < 2:
            return frames
        result: List[str] = []
        for a, b in zip(frames, frames[1:]):
            result.extend([a, f"{a}_{b}_interp"])
        result.append(frames[-1])
        return result


__all__ = ["VideoEffectsPipeline", "RenderedClip"]
