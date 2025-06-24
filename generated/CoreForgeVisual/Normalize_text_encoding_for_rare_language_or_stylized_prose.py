# Auto-generated for Normalize text encoding for rare language or stylized prose
import unicodedata


def normalize_text_encoding(text: str) -> str:
    """Normalize uncommon encodings and return NFC UTF-8 text."""

    normalized = unicodedata.normalize("NFKC", text)
    return normalized.encode("utf-8", "ignore").decode("utf-8")
