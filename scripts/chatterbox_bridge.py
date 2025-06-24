#!/usr/bin/env python3
"""Generate an audio play from a simple script file using a Chatterbox API."""
import argparse
import hashlib
import os
import sys
from typing import List

from dotenv import load_dotenv
from pydub import AudioSegment
import requests
from tqdm import tqdm


class ChatterboxClient:
    """Minimal client for the Chatterbox API."""

    def __init__(self, base_url: str):
        self.base_url = base_url.rstrip("/")

    def synthesize(self, text: str, prompt_path: str) -> bytes:
        """Send a synthesis request and return audio data."""
        with open(prompt_path, "rb") as f:
            files = {"audio_prompt": f}
            data = {"text": text}
            resp = requests.post(f"{self.base_url}/synthesize", files=files, data=data)
            resp.raise_for_status()
            return resp.content


def parse_script(path: str) -> List[tuple[str, str]]:
    lines = []
    with open(path, "r", encoding="utf-8") as f:
        for raw in f:
            if ":" not in raw:
                continue
            speaker, line = raw.split(":", 1)
            lines.append((speaker.strip().lower(), line.strip().strip('"').strip("'")))
    return lines


def md5_hash(text: str) -> str:
    return hashlib.md5(text.encode("utf-8")).hexdigest()


def main() -> None:
    parser = argparse.ArgumentParser(description="Convert script to combined audio")
    parser.add_argument("script", help="Path to the script file")
    parser.add_argument("--output", default="combined_audio.mp3", help="Output file")
    parser.add_argument("--cache", default="audios", help="Cache directory for segments")
    args = parser.parse_args()

    load_dotenv()
    api_url = os.getenv("CHATTERBOX_API_URL")
    if not api_url:
        print("CHATTERBOX_API_URL not set")
        sys.exit(1)

    client = ChatterboxClient(api_url)
    os.makedirs(args.cache, exist_ok=True)

    script_lines = parse_script(args.script)
    segments: List[AudioSegment] = []

    for speaker, line in tqdm(script_lines, desc="Generating", unit="line"):
        key = md5_hash(speaker + line)
        path = os.path.join(args.cache, f"{key}.mp3")
        if os.path.exists(path):
            segment = AudioSegment.from_file(path)
        else:
            prompt = f"{speaker}.mp3"
            audio_data = client.synthesize(line, prompt)
            with open(path, "wb") as f:
                f.write(audio_data)
            segment = AudioSegment.from_file(path)
        segments.append(segment)

    combined = sum(segments[1:], segments[0]) if segments else AudioSegment.empty()
    combined.export(args.output, format="mp3")
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
