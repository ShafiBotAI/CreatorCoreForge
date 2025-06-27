# Auto-generated for Provide DAW-compatible multitrack timelines with labeled scene markers
def provide_daw_compatible(tracks: dict[str, list[str]]) -> list[tuple[str, int]]:
    """Return list of (track name, marker count) for DAW import."""
    return [(name, len(markers)) for name, markers in tracks.items()]
