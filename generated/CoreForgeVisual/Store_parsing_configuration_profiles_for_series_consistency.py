# Auto-generated for Store parsing configuration profiles for series consistency

_profiles: dict[str, dict] = {}

def store_parsing_configuration(series: str, config: dict) -> None:
    """Persist parsing configuration for a series."""
    _profiles[series] = config

def get_parsing_configuration(series: str) -> dict | None:
    """Retrieve stored parsing configuration."""
    return _profiles.get(series)
