# Auto-generated for Store character styles for reuse across scenes and sequels
_style_db: dict[str, dict] = {}

def store_character_styles(name: str, style: dict) -> None:
    """Persist a character style for later reuse."""
    _style_db[name] = style

def get_character_style(name: str) -> dict | None:
    """Retrieve a stored character style if available."""
    return _style_db.get(name)
