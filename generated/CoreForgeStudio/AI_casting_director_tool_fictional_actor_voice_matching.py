# Basic voice matching helper for fictional actors.
def match_voice(target_profile, actors):
    """Select the actor whose voice profile best fits the target.

    Parameters
    ----------
    target_profile : dict
        Dictionary with ``pitch`` and ``tone`` keys.
    actors : dict
        Mapping of actor names to profile dictionaries.
    """
    best_name = None
    best_score = float("inf")
    for name, profile in actors.items():
        score = abs(profile.get("pitch", 0) - target_profile.get("pitch", 0))
        if profile.get("tone") != target_profile.get("tone"):
            score += 1
        if score < best_score:
            best_score = score
            best_name = name
    return best_name
