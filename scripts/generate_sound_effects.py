#!/usr/bin/env python3
"""Generate basic environment and human sound effects.

This script synthesizes simple WAV files without external
libraries. Effects include wind, rain, footsteps, clap, and breath.
"""
import argparse
import math
import random
import wave
import struct

SAMPLE_RATE = 44100

def write_wave(path, samples):
    with wave.open(path, 'w') as wav:
        wav.setnchannels(1)
        wav.setsampwidth(2)
        wav.setframerate(SAMPLE_RATE)
        frames = bytearray()
        for s in samples:
            s = max(-1.0, min(1.0, s))
            frames.extend(struct.pack('<h', int(s * 32767)))
        wav.writeframes(frames)

def generate_wind(duration):
    samples = []
    for i in range(int(SAMPLE_RATE * duration)):
        base = random.uniform(-0.4, 0.4)
        sweep = math.sin(i / SAMPLE_RATE * 0.5) * 0.3
        samples.append(base + sweep)
    return samples

def generate_rain(duration):
    samples = []
    for i in range(int(SAMPLE_RATE * duration)):
        noise = random.uniform(-0.3, 0.3)
        if random.random() < 0.005:
            noise += random.uniform(0.5, 1.0)
        samples.append(noise)
    return samples

def generate_footsteps(duration):
    samples = []
    step_interval = 0.5
    total_samples = int(SAMPLE_RATE * duration)
    for i in range(total_samples):
        t = i / SAMPLE_RATE
        phase = (t % step_interval)
        amp = max(0.0, 1.0 - phase * 8)
        value = math.sin(2 * math.pi * 150 * phase) * amp
        samples.append(value * 0.7)
    return samples

def generate_clap(duration):
    samples = []
    total_samples = int(SAMPLE_RATE * duration)
    for i in range(total_samples):
        t = i / SAMPLE_RATE
        amp = max(0.0, 1.0 - t * 6)
        value = random.uniform(-0.5, 0.5) * amp
        samples.append(value)
    return samples

def generate_breath(duration):
    samples = []
    for i in range(int(SAMPLE_RATE * duration)):
        base = math.sin(2 * math.pi * 200 * i / SAMPLE_RATE)
        envelope = (1 - math.cos(2 * math.pi * i / (SAMPLE_RATE * duration))) / 2
        samples.append(base * envelope * 0.4)
    return samples

EFFECT_MAP = {
    'wind': generate_wind,
    'rain': generate_rain,
    'footsteps': generate_footsteps,
    'clap': generate_clap,
    'breath': generate_breath,
}

def main():
    parser = argparse.ArgumentParser(description='Generate simple SFX')
    parser.add_argument('effect', choices=EFFECT_MAP.keys(), help='effect name')
    parser.add_argument('output', help='output WAV file')
    parser.add_argument('--duration', type=float, default=2.0, help='length in seconds')
    args = parser.parse_args()

    samples = EFFECT_MAP[args.effect](args.duration)
    write_wave(args.output, samples)
    print(f'Created {args.output}')

if __name__ == '__main__':
    main()
