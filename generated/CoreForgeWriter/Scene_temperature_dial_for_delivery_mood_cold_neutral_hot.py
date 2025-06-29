# Auto-generated for Scene temperature dial for delivery mood (cold/neutral/hot)
def scene_temperature_dial(mood="neutral"):
    """Return a temperature value between 0 and 1 for the given mood."""
    mapping = {"cold": 0.2, "neutral": 0.5, "hot": 0.8}
    return mapping.get(mood, 0.5)
