import threading
import time

class SleepReadMode:
    """Simplified sleep timer with fade callbacks."""

    def __init__(self):
        self.is_active = False
        self._timer = None
        self._start = 0.0
        self._duration = 0.0
        self._fade_duration = 0.0
        self._fade_cb = None
        self._completion_cb = None

    def _tick(self):
        if not self.is_active:
            return
        elapsed = time.time() - self._start
        if elapsed >= self._duration:
            self.is_active = False
            if self._completion_cb:
                self._completion_cb()
            return
        if elapsed >= self._duration - self._fade_duration and self._fade_duration > 0:
            progress = (elapsed - (self._duration - self._fade_duration)) / self._fade_duration
            if self._fade_cb:
                self._fade_cb(max(0.0, min(1.0, 1.0 - progress)))
        self._timer = threading.Timer(0.5, self._tick)
        self._timer.start()

    def start(self, duration, fade_duration=5.0, fade=lambda v: None, completion=lambda: None):
        if self.is_active:
            return
        self.is_active = True
        self._duration = duration
        self._fade_duration = fade_duration
        self._fade_cb = fade
        self._completion_cb = completion
        self._start = time.time()
        self._timer = threading.Timer(0.5, self._tick)
        self._timer.start()

    def cancel(self):
        if self._timer:
            self._timer.cancel()
            self._timer = None
        self.is_active = False
