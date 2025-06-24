# Auto-generated for Tag visual rhythm speed (slow visual poetry vs fast action montage)
def tag_visual_rhythm(frames_per_second: float) -> str:
    """Classify visual rhythm as 'slow' or 'fast'."""

    return "fast" if frames_per_second >= 30 else "slow"
