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

    src = Path(ebook_path)
    if not src.is_file():
        raise FileNotFoundError(src)

    out_dir = Path(output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    repo_root = Path(__file__).resolve().parents[2]
    script = repo_root / "scripts" / "ebook2audiobook_bridge.py"
    subprocess.run([sys.executable, str(script), str(src), "-o", str(out_dir)], check=True)


def advanced_normalize_wav_file(input_file: str, output_file: str) -> None:
    """Apply advanced normalization using ffmpeg filters from ebook2audiobook."""
    ffmpeg_cmd = [
        "ffmpeg", "-i", input_file,
        "-af",
        "agate=threshold=-25dB:ratio=1.4:attack=10:release=250,"
        "afftdn=nf=-70,"
        "acompressor=threshold=-20dB:ratio=2:attack=80:release=200:makeup=1dB,"
        "loudnorm=I=-16:TP=-3:LRA=7:linear=true,"
        "equalizer=f=250:t=q:w=2:g=-3,"
        "equalizer=f=150:t=q:w=2:g=2,"
        "equalizer=f=3000:t=q:w=2:g=3,"
        "equalizer=f=5500:t=q:w=2:g=-4,"
        "equalizer=f=9000:t=q:w=2:g=-2,"
        "highpass=f=63",
        "-y", output_file,
    ]
    subprocess.run(ffmpeg_cmd, check=True)


def advanced_normalize_wav_folder(folder_path: str) -> None:
    """Normalize all WAV files in ``folder_path`` using :func:`advanced_normalize_wav_file`."""
    folder = Path(folder_path)
    if not folder.is_dir():
        raise FileNotFoundError(folder_path)

    for path in folder.rglob("*.wav"):
        tmp_file = path.with_suffix(".tmp.wav")
        advanced_normalize_wav_file(str(path), str(tmp_file))
        Path(tmp_file).replace(path)


def convert_folder_to_audio(folder_path: str, output_base_dir: str = "output") -> None:
    """Convert every supported ebook in ``folder_path`` to audio using
    :func:`convert_ebook_to_audio`.

    Parameters
    ----------
    folder_path: str
        Directory containing ebook files.
    output_base_dir: str, optional
        Base directory where per-book audio folders will be created.
    """
    folder = Path(folder_path)
    if not folder.is_dir():
        raise FileNotFoundError(folder_path)

    ebook_exts = {".epub", ".pdf", ".txt", ".docx"}
    for ebook in folder.iterdir():
        if ebook.suffix.lower() in ebook_exts:
            out_dir = Path(output_base_dir) / ebook.stem
            out_dir.mkdir(parents=True, exist_ok=True)
            convert_ebook_to_audio(str(ebook), str(out_dir))

