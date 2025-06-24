"""Support utilities for audio fingerprinting and casting previews."""

from __future__ import annotations

import hashlib
from pathlib import Path


def offer_beta_features(audio_file: str) -> str:
    """Return SHA256 fingerprint for ``audio_file``."""

    data = Path(audio_file).read_bytes()
    return hashlib.sha256(data).hexdigest()


__all__ = ["offer_beta_features"]
