class SpatialAudioSupport:
    """Toggle simple 3D audio support."""

    def __init__(self):
        self.is_3d_enabled = False

    def enable_3d(self, enabled: bool):
        self.is_3d_enabled = enabled
