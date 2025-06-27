# Auto-generated for Curriculum designer and quiz builder
from __future__ import annotations


class CurriculumDesigner:
    """Manage lessons and build simple quizzes."""

    def __init__(self) -> None:
        self.lessons: list[dict[str, str]] = []

    def add_lesson(self, title: str, content: str) -> None:
        self.lessons.append({"title": title, "content": content})

    def build_quiz(self) -> list[dict[str, str]]:
        """Create naive quiz questions for each lesson."""
        return [
            {"question": f"What is {lesson['title']} about?", "answer": lesson["title"]}
            for lesson in self.lessons
        ]


__all__ = ["CurriculumDesigner"]
