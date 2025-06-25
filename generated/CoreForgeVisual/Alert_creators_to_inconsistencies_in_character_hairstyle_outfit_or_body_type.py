# Auto-generated for Alert creators to inconsistencies in character hairstyle, outfit, or body type

def alert_creators_to(current: dict, previous: dict) -> list:
    """Return list of fields that changed between current and previous states."""
    issues = []
    for field in ("hairstyle", "outfit", "body_type"):
        if current.get(field) != previous.get(field):
            issues.append(field)
    return issues
