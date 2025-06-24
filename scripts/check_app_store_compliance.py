#!/usr/bin/env python3
import os
import plistlib
import sys

REQUIRED_KEYS = ["CFBundleIdentifier", "CFBundleVersion", "CFBundleShortVersionString"]
PRIVACY_KEYS = [
    "NSCameraUsageDescription",
    "NSMicrophoneUsageDescription",
    "NSPhotoLibraryAddUsageDescription",
]

def check_plist(plist_path):
    with open(plist_path, 'rb') as fp:
        data = plistlib.load(fp)
    missing = [k for k in REQUIRED_KEYS if k not in data]
    privacy_present = any(k in data for k in PRIVACY_KEYS)
    return missing, privacy_present


def main():
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    apps_dir = os.path.join(repo_root, "apps")
    failed = False
    for root, dirs, files in os.walk(apps_dir):
        if "Info.plist" in files:
            plist_path = os.path.join(root, "Info.plist")
            missing, privacy_present = check_plist(plist_path)
            rel = os.path.relpath(plist_path, repo_root)
            if missing:
                print(f"[FAIL] {rel} missing keys: {', '.join(missing)}")
                failed = True
            if not privacy_present:
                print(f"[FAIL] {rel} missing privacy usage descriptions")
                failed = True
            app_root = os.path.abspath(os.path.join(root, os.pardir, os.pardir))
            assets_dir = os.path.join(app_root, "AppStoreAssets")
            if not os.path.isdir(assets_dir):
                print(f"[FAIL] {rel}: AppStoreAssets folder not found")
                failed = True
    if failed:
        sys.exit(1)
    print("All App Store compliance checks passed.")

if __name__ == "__main__":
    main()
