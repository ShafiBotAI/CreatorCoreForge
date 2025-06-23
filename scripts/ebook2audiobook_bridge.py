#!/usr/bin/env python3
"""Run the ebook2audiobook snapshot to convert an ebook to audio."""
import argparse
import os
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser(
        description="Convert an ebook to audio using the bundled ebook2audiobook script")
    parser.add_argument("ebook", help="Path to the ebook file")
    parser.add_argument("-o", "--output", default="output", help="Directory for generated audio")
    args = parser.parse_args()

    script_path = os.path.join("apps", "ebook2audiobook", "app.py")
    cmd = [sys.executable, script_path, "--headless", "--ebook", os.path.abspath(args.ebook),
           "--output_dir", os.path.abspath(args.output)]
    subprocess.run(cmd, check=True)

if __name__ == "__main__":
    main()
