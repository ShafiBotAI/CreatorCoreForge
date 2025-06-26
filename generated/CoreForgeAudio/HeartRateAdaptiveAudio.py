class HeartRateAdaptiveAudio:
    """Adjust playback intensity using heart rate."""

    def adjust(self, intensity: int) -> float:
        return max(0.5, min(2.0, intensity / 100.0))
