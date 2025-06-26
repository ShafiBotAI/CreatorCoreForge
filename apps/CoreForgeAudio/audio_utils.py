from pydub import AudioSegment


def normalize_volume(path: str, target_dbfs: float = -20.0) -> AudioSegment:
    """Return audio normalized to a target volume."""
    audio = AudioSegment.from_file(path)
    change = target_dbfs - audio.dBFS
    return audio.apply_gain(change)
