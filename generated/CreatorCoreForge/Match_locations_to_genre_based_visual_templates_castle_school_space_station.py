from typing import Dict

def match_locations_to(location: str) -> str:
    """Return a genre-based template for the given location string."""
    templates: Dict[str, list[str]] = {
        "castle": ["castle", "fortress", "palace"],
        "school": ["school", "academy", "university"],
        "space station": ["space station", "orbital", "astro-base"],
    }
    lower = location.lower()
    for name, keywords in templates.items():
        if any(k in lower for k in keywords):
            return name
    return "generic"
