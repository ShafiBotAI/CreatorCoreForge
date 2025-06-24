#!/usr/bin/env python3
import os
from PIL import Image

SIZES = [20, 29, 40, 60, 76, 83, 1024]

def generate_icons(target_dir: str, color=(0, 122, 255)):
    os.makedirs(target_dir, exist_ok=True)
    for size in SIZES:
        img = Image.new("RGB", (size, size), color)
        path = os.path.join(target_dir, f"icon_{size}x{size}.png")
        img.save(path)
        print(f"Created {path}")

def main():
    target = os.environ.get("ICON_OUTPUT", "./icons")
    generate_icons(target)

if __name__ == '__main__':
    main()
