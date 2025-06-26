# Auto-generated for Allow creator-defined "main" timeline and secondary forks

class TimelineManager:
    def __init__(self):
        self.timelines = {"main": []}
        self.main_tag = "main"

    def add_scene(self, tag: str, scene):
        self.timelines.setdefault(tag, []).append(scene)

    def get_timeline(self, tag: str):
        return self.timelines.get(tag, [])

    def set_main_timeline(self, tag: str) -> None:
        """Designate an existing timeline as the main one."""
        if tag in self.timelines:
            self.main_tag = tag

    def fork_timeline(self, source_tag: str, new_tag: str) -> None:
        """Create a fork from an existing timeline."""
        self.timelines[new_tag] = list(self.timelines.get(source_tag, []))
