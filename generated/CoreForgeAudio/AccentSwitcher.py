from typing import Dict

class AccentSwitcher:
    """Simple text-based accent transformer."""

    def __init__(self, accent: str = "standard"):
        self.accent = accent.lower()
        self.rules: Dict[str, Dict[str, str]] = {
            "pirate": {"you": "ye", "my": "me", "is": "be"},
            "australian": {"er": "ah", "mate": "maite"},
            "cockney": {"th": "f", "h": ""}
        }

    def set_accent(self, accent: str) -> None:
        self.accent = accent.lower()

    def transform(self, text: str) -> str:
        rules = self.rules.get(self.accent)
        if not rules:
            return text
        for src, repl in rules.items():
            text = text.replace(src, repl)
        return text
