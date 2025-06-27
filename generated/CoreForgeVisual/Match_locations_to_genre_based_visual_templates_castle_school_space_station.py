# Auto-generated for Match locations to genre-based visual templates (castle, school, space station)
TEMPLATES = {
    "castle": ["castle", "fortress"],
    "school": ["school", "academy"],
    "space": ["space station", "moon base"],
}

def match_locations_to(description: str) -> str:
    """Return the best template category for a location description."""
    text = description.lower()
    for key, keywords in TEMPLATES.items():
        if any(k in text for k in keywords):
            return key
    return "generic"
