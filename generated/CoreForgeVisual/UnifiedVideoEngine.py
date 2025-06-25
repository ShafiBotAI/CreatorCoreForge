# Auto-generated for UnifiedVideoEngine
"""Utility functions for combining multiple video segments into a single file."""

from __future__ import annotations

import asyncio
import logging
import os
from typing import Iterable, Optional

try:
    from moviepy.editor import VideoFileClip, concatenate_videoclips
except Exception:  # pragma: no cover - optional dependency
    VideoFileClip = None  # type: ignore
    concatenate_videoclips = None  # type: ignore


def unified_video_engine(
    video_paths: Iterable[str],
    output_path: str,
    *,
    fps: int = 24,
    include_audio: bool = True,
) -> str:
    """Merge videos into a single clip and write to ``output_path``.

    Parameters
    ----------
    video_paths:
        Iterable of video file paths to merge in order.
    output_path:
        Destination path for the merged video file.
    fps:
        Frames per second for the output video.
    include_audio:
        If ``False``, strips audio tracks from the merged clip.

    Returns
    -------
    str
        The path to the rendered video.

    Raises
    ------
    RuntimeError
        If the ``moviepy`` dependency is missing.
    FileNotFoundError
        If any of the ``video_paths`` do not exist.
    ValueError
        If no ``video_paths`` are provided.
    """

    if VideoFileClip is None or concatenate_videoclips is None:
        raise RuntimeError("moviepy is required for unified video rendering")

    paths = list(video_paths)
    if not paths:
        raise ValueError("No video paths supplied")

    clips = []
    for path in paths:
        if not os.path.exists(path):
            raise FileNotFoundError(path)
        clip = VideoFileClip(path)
        if not include_audio:
            clip = clip.without_audio()
        clips.append(clip)

    final = concatenate_videoclips(clips)
    final.write_videofile(output_path, fps=fps)

    for clip in clips:
        clip.close()
    final.close()
    logging.info("Unified video written to %s", output_path)
    return output_path


async def unified_video_engine_async(
    video_paths: Iterable[str],
    output_path: str,
    *,
    fps: int = 24,
    include_audio: bool = True,
    loop: Optional[asyncio.AbstractEventLoop] = None,
) -> str:
    """Async wrapper around :func:`unified_video_engine`."""

    loop = loop or asyncio.get_event_loop()
    return await loop.run_in_executor(
        None, unified_video_engine, video_paths, output_path, fps, include_audio
    )

