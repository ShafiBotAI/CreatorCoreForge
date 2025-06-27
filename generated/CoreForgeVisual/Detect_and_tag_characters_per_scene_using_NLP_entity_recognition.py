# Auto-generated for Detect and tag characters per scene using NLP entity recognition
import re

def detect_and_tag(text: str) -> list[str]:
    """Very naive proper-noun detection for demo purposes."""
    return re.findall(r"[A-Z][a-zA-Z]+", text)
