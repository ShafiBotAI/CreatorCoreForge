import threading
import time

class NarrationScheduler:
    """Schedule narration tasks at specific times."""

    def __init__(self):
        self.tasks = {}

    def schedule(self, when: float, action):
        delay = max(0, when - time.time())
        timer = threading.Timer(delay, lambda: (action(), self.tasks.pop(when, None)))
        self.tasks[when] = timer
        timer.start()

    @property
    def pending_count(self) -> int:
        return len(self.tasks)

    def cancel_all(self):
        for t in list(self.tasks.values()):
            t.cancel()
        self.tasks.clear()
