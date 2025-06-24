import argparse
import os
import shutil
import subprocess
from typing import List


def assemble_videos(inputs: List[str], output: str) -> None:
    """Concatenate multiple video files using ffmpeg's concat demuxer."""
    list_file = "video_list.txt"
    with open(list_file, "w") as handle:
        for path in inputs:
            abs_path = os.path.abspath(path)
            handle.write(f"file '{abs_path}'\n")

    ffmpeg_cmd = [
        shutil.which("ffmpeg") or "ffmpeg",
        "-y",
        "-f",
        "concat",
        "-safe",
        "0",
        "-i",
        list_file,
        "-c",
        "copy",
        output,
    ]
    subprocess.run(ffmpeg_cmd, check=True)
    os.remove(list_file)

def main() -> None:
    parser = argparse.ArgumentParser(description="Assemble segments into an ultra long video")
    parser.add_argument("output", help="Output video filename")
    parser.add_argument("inputs", nargs='+', help="Ordered list of video segments")
    args = parser.parse_args()

    assemble_videos(args.inputs, args.output)


if __name__ == "__main__":
    main()
