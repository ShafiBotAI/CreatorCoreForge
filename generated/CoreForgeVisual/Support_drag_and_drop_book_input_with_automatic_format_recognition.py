# Auto-generated for Support drag-and-drop book input with automatic format recognition
def support_drag_and(path: str) -> str:
    """Return detected file extension for a dropped book."""
    if '.' in path:
        return path.split('.')[-1].lower()
    return 'unknown'
