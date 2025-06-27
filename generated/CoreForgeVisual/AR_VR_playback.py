# Auto-generated for AR/VR playback
from dataclasses import dataclass
from typing import List, Any


@dataclass
class PlaybackState:
    frames: List[Any]
    position: int = 0
    playing: bool = False

    def step(self) -> Any:
        """Advance playback if playing and return the current frame."""
        if self.playing and self.position < len(self.frames) - 1:
            self.position += 1
        return self.current_frame

    def play(self) -> None:
        self.playing = True

    def pause(self) -> None:
        self.playing = False

    def reset(self) -> None:
        self.position = 0

    @property
    def current_frame(self) -> Any:
        return self.frames[self.position]


def ar_vr_playback(frames):
    """Return a playback state object for AR/VR frames."""
    return PlaybackState(frames)
