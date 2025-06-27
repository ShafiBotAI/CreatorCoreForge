# Auto-generated for Course marketplace and user sharing
from __future__ import annotations


class CourseMarketplace:
    """In-memory course catalog with basic share helpers."""

    def __init__(self) -> None:
        self._courses: dict[str, str] = {}

    def add_course(self, name: str, url: str) -> None:
        """Register a course with a download URL."""
        self._courses[name] = url

    def list_courses(self) -> list[str]:
        """Return available course names."""
        return list(self._courses.keys())

    def share_course(self, name: str, email: str) -> str:
        """Pretend to send a share link via email."""
        if name not in self._courses:
            return f"{name} not found"
        return f"Shared {name} with {email}"


__all__ = ["CourseMarketplace"]
