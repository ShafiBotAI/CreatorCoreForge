#!/usr/bin/env python3
import time
import random

# Simple load simulator for audio/render pipelines

def simulate_load(iterations: int = 1000):
    for _ in range(iterations):
        _ = [random.random() * random.random() for _ in range(1000)]
        time.sleep(0.001)

if __name__ == "__main__":
    simulate_load()
