# Auto-generated for Add emotion-to-pitch/pace modulation (e.g., sad = slower, lower)
from pydub import AudioSegment
from pydub.effects import speedup


EMOTION_SETTINGS = {
    "sad": {"speed": 0.9, "semitone": -2},
    "angry": {"speed": 1.1, "semitone": 2},
    "happy": {"speed": 1.05, "semitone": 1},
    "neutral": {"speed": 1.0, "semitone": 0},
}


def add_emotion_to(segment: AudioSegment, emotion: str = "neutral") -> AudioSegment:
    """Return ``segment`` with simple pitch and pace adjustments for ``emotion``.

    The implementation uses a basic frame-rate adjustment for pitch shifting and
    ``speedup`` for tempo changes. Only minor shifts are applied to avoid
    significant audio artifacts. Supported emotion keys are ``sad``,
    ``angry``, ``happy`` and ``neutral``.
    """

    settings = EMOTION_SETTINGS.get(emotion.lower(), EMOTION_SETTINGS["neutral"])

    # Apply tempo change
    modified = segment
    if settings["speed"] != 1.0:
        modified = speedup(modified, playback_speed=settings["speed"], chunk_size=50, crossfade=25)

    # Apply pitch shift using a simple frame rate change
    if settings["semitone"]:
        shift = 2 ** (settings["semitone"] / 12)
        new_rate = int(modified.frame_rate * shift)
        modified = modified._spawn(modified.raw_data, overrides={"frame_rate": new_rate}).set_frame_rate(segment.frame_rate)

    return modified


__all__ = ["add_emotion_to"]
