from pydub import AudioSegment
import subprocess
import sys
from pathlib import Path


def normalize_volume(path: str, target_dbfs: float = -20.0) -> AudioSegment:
    """Return audio normalized to a target volume."""
    audio = AudioSegment.from_file(path)
    change = target_dbfs - audio.dBFS
    return audio.apply_gain(change)


def convert_ebook_to_audio(ebook_path: str, output_dir: str = "output") -> None:
    """Run the bundled ebook2audiobook pipeline on an ebook.

    Parameters
    ----------
    ebook_path: str
        Path to the input eBook file.
    output_dir: str, optional
        Directory where audio files will be written.
    """

    repo_root = Path(__file__).resolve().parents[2]
    script = repo_root / "scripts" / "ebook2audiobook_bridge.py"
    subprocess.run([sys.executable, str(script), ebook_path, "-o", output_dir], check=True)
