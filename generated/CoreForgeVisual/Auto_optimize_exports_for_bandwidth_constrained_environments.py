# Auto-generated for Auto-optimize exports for bandwidth-constrained environments
def auto_optimize_exports(size_mb: float, limit_mb: float = 50.0) -> float:
    """Return adjusted size respecting the bandwidth limit."""

    if size_mb > limit_mb:
        return limit_mb
    return size_mb
