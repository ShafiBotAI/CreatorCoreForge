# Auto-generated for Export to ePub, PDF, audiobook formats (Codex)
def export_to_epub(text, path):
    """Export text to a fake EPUB/PDF/Audiobook path."""
    with open(path, "w", encoding="utf-8") as f:
        f.write(text)
    return path
