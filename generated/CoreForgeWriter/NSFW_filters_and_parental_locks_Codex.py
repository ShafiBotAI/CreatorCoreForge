# Auto-generated for NSFW filters and parental locks (Codex)
def nsfw_filters_and(text):
    """Simple NSFW filter returning censored text."""
    banned_words = {"nsfw", "explicit"}
    words = text.split()
    filtered = ["***" if w.lower() in banned_words else w for w in words]
    return " ".join(filtered)
