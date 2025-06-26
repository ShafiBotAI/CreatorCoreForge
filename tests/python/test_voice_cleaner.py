import sys
from pathlib import Path
from pydub.generators import Sine

# Ensure the project root is on the path
sys.path.append(str(Path(__file__).resolve().parents[2]))

from apps.CoreForgeAudio.services.voice_cleaner import clean_voice_sample
from shutil import which


def _tone(path: Path, duration=200):
    Sine(440).to_audio_segment(duration=duration).export(path, format="wav")


def test_clean_voice_sample(tmp_path: Path):
    if which("ffmpeg") is None:
        import pytest
        pytest.skip("ffmpeg not installed")
    src = tmp_path / "source.wav"
    _tone(src)
    out_dir = tmp_path / "out"
    out_file = clean_voice_sample(str(src), str(out_dir))
    assert Path(out_file).exists()
