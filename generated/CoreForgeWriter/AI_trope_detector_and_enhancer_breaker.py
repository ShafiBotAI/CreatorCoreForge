# Auto-generated for AI trope detector and enhancer/breaker
TROPES = {"chosen one", "secret twin", "amnesia"}


def ai_trope_detector(text):
    """Detect simple trope keywords in text."""
    found = [t for t in TROPES if t in text.lower()]
    return found
