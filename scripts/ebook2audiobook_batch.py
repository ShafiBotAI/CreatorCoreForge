#!/usr/bin/env python3
"""Batch convert ebooks to audio using the ebook2audiobook snapshot."""
from pathlib import Path
import argparse
from apps.CoreForgeAudio.audio_utils import convert_folder_to_audio


def main() -> None:
    parser = argparse.ArgumentParser(description="Convert a folder of ebooks to audio")
    parser.add_argument("folder", help="Folder containing ebooks")
    parser.add_argument("-o", "--output", default="output", help="Output base directory")
    args = parser.parse_args()
    convert_folder_to_audio(args.folder, args.output)


if __name__ == "__main__":
    main()
