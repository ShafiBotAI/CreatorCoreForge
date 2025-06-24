#!/usr/bin/env python3
"""Generate short mood-based music loops.

This tool synthesizes simple sine wave tracks corresponding to a mood
string. The output is a mono 44.1 kHz WAV file created without external
dependencies.
"""
import argparse
import math
import struct
import wave

SAMPLE_RATE = 44100

MOOD_FREQ = {
    "calm": 220,
    "tense": 880,
    "happy": 660,
}

def write_wave(path: str, samples):
    with wave.open(path, "w") as wav:
        wav.setnchannels(1)
        wav.setsampwidth(2)
        wav.setframerate(SAMPLE_RATE)
        frames = bytearray()
        for s in samples:
            s = max(-1.0, min(1.0, s))
            frames.extend(struct.pack("<h", int(s * 32767)))
        wav.writeframes(frames)

def generate_music(mood: str, duration: float) -> list:
    frequency = MOOD_FREQ.get(mood.lower(), 440)
    frame_count = int(SAMPLE_RATE * duration)
    samples = []
    for i in range(frame_count):
        t = i / SAMPLE_RATE
        samples.append(math.sin(2 * math.pi * frequency * t) * 0.4)
    return samples

def main():
    parser = argparse.ArgumentParser(description="Generate a mood-based music loop")
    parser.add_argument("mood", help="mood label: calm, tense, happy, etc.")
    parser.add_argument("output", nargs="?", help="output WAV file")
    parser.add_argument("--duration", type=float, default=1.0, help="length in seconds")
    args = parser.parse_args()

    out_path = args.output or f"{args.mood}.wav"
    samples = generate_music(args.mood, args.duration)
    write_wave(out_path, samples)
    print(f"Created {out_path}")

if __name__ == "__main__":
    main()
