# Auto-generated for Genre selector + fast draft mode
GENRES = ["fantasy", "sci-fi", "romance", "mystery"]


def genre_selector_fast(genre):
    """Return True if genre is supported for fast draft mode."""
    return genre.lower() in GENRES
