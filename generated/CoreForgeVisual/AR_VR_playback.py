# Auto-generated for AR/VR playback
class PlaybackState:
    def __init__(self, frames):
        self.frames = frames
        self.position = 0

    def step(self):
        if self.position < len(self.frames) - 1:
            self.position += 1
        return self.current_frame

    @property
    def current_frame(self):
        return self.frames[self.position]


def ar_vr_playback(frames):
    """Return a playback state object for AR/VR frames."""
    return PlaybackState(frames)
