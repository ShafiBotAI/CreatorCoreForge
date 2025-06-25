# Auto-generated for Gate export privileges by subscription tier (e.g., 4K = Creator+ only)
def gate_export_privileges(tier: str, resolution: str) -> bool:
    """Return True if the tier is allowed to export at the given resolution."""

    if resolution == "4K":
        return tier.lower() in {"creator", "enterprise"}
    return True
