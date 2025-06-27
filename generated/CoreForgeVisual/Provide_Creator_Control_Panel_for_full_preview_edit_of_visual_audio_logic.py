# Auto-generated for Provide Creator Control Panel for full preview/edit of visual/audio logic
class CreatorControlPanel:
    """Simple preview/edit control panel."""

    def __init__(self) -> None:
        self.preview_enabled = False

    def toggle_preview(self) -> None:
        self.preview_enabled = not self.preview_enabled

    def is_preview_enabled(self) -> bool:
        return self.preview_enabled
