# Auto-generated for AI “coach” and performance review for narration/voice
from __future__ import annotations
import soundfile as sf
import numpy as np


def ai_coach_and(audio_path: str) -> dict:
    """Return simple narration metrics from an audio file."""
    try:
        data, sr = sf.read(audio_path)
        duration = len(data) / float(sr)
        rms = float(np.sqrt(np.mean(np.square(data))))
        return {"duration": duration, "rms": rms}
    except Exception as e:
        return {"error": str(e)}
