# Auto-generated for Enable fingerprinted voice tagging for IP verification
import hashlib


def enable_fingerprinted_voice(voice_data: bytes) -> str:
    """Return a simple hash representing the voice fingerprint."""
    return hashlib.sha256(voice_data).hexdigest()
