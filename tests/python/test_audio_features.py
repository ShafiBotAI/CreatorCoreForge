import os
import tempfile
from pathlib import Path
from pydub.generators import Sine
from pydub import AudioSegment

from generated.CoreForgeAudio.MultiverseBookLinker import MultiverseBookLinker
from generated.CoreForgeAudio.FullBookRender import full_book_render
from generated.CoreForgeAudio.AudiobookStoreExporter import export_package
from generated.CoreForgeAudio.PublishingReportGenerator import generate_report
from generated.CoreForgeAudio.SeriesManager import SeriesManager


def test_multiverse_book_linker():
    linker = MultiverseBookLinker()
    linker.link_books("A", "B")
    assert "B" in linker.get_links("A")
    assert "A" in linker.get_links("B")


def test_series_manager():
    mgr = SeriesManager()
    mgr.add_book("Book1")
    mgr.add_book("Book2")
    assert mgr.list_books() == ["Book1", "Book2"]
    assert mgr.current() == "Book2"


def test_full_book_render_and_export(tmp_path: Path):
    chapter1 = tmp_path / "c1.wav"
    chapter2 = tmp_path / "c2.wav"
    Sine(440).to_audio_segment(duration=100).export(chapter1, format="wav")
    Sine(880).to_audio_segment(duration=100).export(chapter2, format="wav")

    out_path = tmp_path / "book.wav"
    full_book_render([str(chapter1), str(chapter2)], str(out_path))
    assert out_path.is_file()

    package_dir = tmp_path / "pkg"
    pkg = export_package(str(out_path), {"title": "Test"}, str(package_dir))
    assert os.path.isfile(pkg)

    report = generate_report(str(out_path), {"title": "Test"})
    assert report["duration_seconds"] > 0
    assert report["size_bytes"] == out_path.stat().st_size
