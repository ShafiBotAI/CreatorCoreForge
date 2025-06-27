import sys
from pathlib import Path
from pydub.generators import Sine
from shutil import which

# Ensure project root is on path
sys.path.append(str(Path(__file__).resolve().parents[2]))

from apps.CoreForgeAudio.audio_utils import advanced_normalize_wav_file


def _tone(path: Path, duration=200):
    Sine(440).to_audio_segment(duration=duration).export(path, format="wav")


def test_advanced_normalize_wav_file(tmp_path: Path):
    if which("ffmpeg") is None:
        import pytest
        pytest.skip("ffmpeg not installed")
    src = tmp_path / "tone.wav"
    out = tmp_path / "out.wav"
    _tone(src)
    advanced_normalize_wav_file(str(src), str(out))
    assert out.exists()
