class Review:
    def __init__(self, user: str, rating: int, comment: str):
        self.user = user
        self.rating = max(1, min(5, rating))
        self.comment = comment


class VoiceReviewSystem:
    """Stores voice reviews and ratings."""

    def __init__(self):
        self.reviews = {}

    def add_review(self, name: str, user: str, rating: int, comment: str):
        r = Review(user, rating, comment)
        self.reviews.setdefault(name, []).append(r)

    def average_rating(self, name: str) -> float:
        values = self.reviews.get(name, [])
        if not values:
            return 0.0
        return sum(r.rating for r in values) / len(values)

    def all_reviews(self, name: str):
        return self.reviews.get(name, [])

    def clear(self):
        self.reviews.clear()
