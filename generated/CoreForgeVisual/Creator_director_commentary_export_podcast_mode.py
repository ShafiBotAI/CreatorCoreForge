# Auto-generated for Creator/director commentary export, podcast mode
from __future__ import annotations

from pathlib import Path
from typing import Iterable

import wave


def creator_director_commentary(audio_tracks: Iterable[Path], output: Path) -> Path:
    """Concatenate ``audio_tracks`` into ``output`` as a simple podcast."""

    with wave.open(str(output), "wb") as out_wav:
        for path in audio_tracks:
            with wave.open(str(path), "rb") as wav:
                if out_wav.getnchannels() == 0:
                    out_wav.setparams(wav.getparams())
                out_wav.writeframes(wav.readframes(wav.getnframes()))
    return output
