# Auto-generated for Recommend artistic adjustments based on visual symbolism norms
VISUAL_SYMBOLISM = {
    "hero": "use strong key light",
    "villain": "add high-contrast shadows",
}

def recommend_artistic_adjustments(archetype: str) -> str:
    """Return a lighting or framing suggestion based on archetype."""
    return VISUAL_SYMBOLISM.get(archetype, "standard lighting")
