# Auto-generated for Add blur, shake, or light flash FX for dramatic or horror moments
def add_blur_shake(intensity: float) -> str:
    """Return a description of the applied FX for tests."""

    if intensity > 0.7:
        return "light_flash"
    if intensity > 0.4:
        return "shake"
    if intensity > 0.1:
        return "blur"
    return "none"
