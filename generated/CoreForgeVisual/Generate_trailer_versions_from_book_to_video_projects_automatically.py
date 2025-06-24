# Auto-generated for Generate trailer versions from book-to-video projects automatically
def generate_trailer_versions(duration: float, ratio: float = 0.1) -> float:
    """Return trailer duration calculated from full duration and ratio."""

    return max(duration * ratio, 0)
