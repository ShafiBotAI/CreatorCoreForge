# Auto-generated for Allow in-app purchases for one-time HD or commercial use licenses
def allow_in_app(user_balance: float, price: float) -> float:
    """Deduct price from balance and return the new balance."""

    if user_balance >= price:
        return user_balance - price
    return user_balance
