# Auto-generated for Emotion/genre/tone heatmaps, viral templates
def emotion_genre_tone(scores: list[int]) -> float:
    """Return average tone score used for heatmap intensity."""
    return sum(scores) / len(scores) if scores else 0.0
