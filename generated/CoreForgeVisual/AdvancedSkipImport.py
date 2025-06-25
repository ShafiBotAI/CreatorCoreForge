# Auto-generated for AdvancedSkipImport

def advancedskipimport(lines: list, skip_indices: set) -> list:
    """Return lines excluding any indices in skip_indices."""
    return [l for i, l in enumerate(lines) if i not in skip_indices]
