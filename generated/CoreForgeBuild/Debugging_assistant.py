# Auto-generated for Debugging assistant
"""Collect and return debug logs for builds."""

class DebuggingAssistant:
    def __init__(self) -> None:
        self.logs: list[str] = []

    def log(self, message: str) -> None:
        self.logs.append(message)

    def last_log(self) -> str | None:
        return self.logs[-1] if self.logs else None

    def all_logs(self) -> list[str]:
        return self.logs[:]


__all__ = ["DebuggingAssistant"]
