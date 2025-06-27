import sys
from pathlib import Path
import builtins
import pytest

sys.path.append(str(Path(__file__).resolve().parents[2]))

from apps.CoreForgeAudio import audio_utils


def test_convert_folder_to_audio(monkeypatch, tmp_path):
    called = []

    def fake_convert(path, out):
        called.append((Path(path), Path(out)))

    monkeypatch.setattr(audio_utils, "convert_ebook_to_audio", fake_convert)

    (tmp_path / "a.epub").touch()
    (tmp_path / "b.pdf").touch()
    audio_utils.convert_folder_to_audio(str(tmp_path), str(tmp_path / "out"))

    assert {c[0].name for c in called} == {"a.epub", "b.pdf"}
    assert all(str(tmp_path / "out" / c[0].stem) == str(c[1]) for c in called)


def test_extract_and_clean_voice_missing(monkeypatch, tmp_path):
    from apps.CoreForgeAudio.services import voice_cleaner

    def fake_import(name, *args, **kwargs):
        if name.startswith("apps.ebook2audiobook"):
            raise ImportError
        return orig_import(name, *args, **kwargs)

    orig_import = builtins.__import__
    monkeypatch.setattr(builtins, "__import__", fake_import)

    sample = tmp_path / "sample.wav"
    sample.touch()
    with pytest.raises(ImportError):
        voice_cleaner.extract_and_clean_voice(str(sample), str(tmp_path))
