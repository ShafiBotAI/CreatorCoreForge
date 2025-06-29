# Auto-generated for Persist promo codes across launches
PROMO_STORAGE = {}


def persist_promo_codes(code):
    """Store a promo code for later retrieval."""
    PROMO_STORAGE[code] = True
    return list(PROMO_STORAGE.keys())
