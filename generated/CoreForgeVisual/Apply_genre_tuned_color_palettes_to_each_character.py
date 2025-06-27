# Auto-generated for Apply genre-tuned color palettes to each character
GENRE_PALETTES = {
    "fantasy": ["purple", "gold"],
    "horror": ["darkred", "black"],
    "scifi": ["blue", "silver"],
}

def apply_genre_tuned(character: str, genre: str) -> dict:
    """Return a color palette suggestion for the given character and genre."""
    palette = GENRE_PALETTES.get(genre, ["neutral"])
    return {"character": character, "palette": palette}
