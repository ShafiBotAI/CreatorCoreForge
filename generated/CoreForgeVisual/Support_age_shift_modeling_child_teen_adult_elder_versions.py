# Auto-generated for Support age-shift modeling (child, teen, adult, elder versions)
from dataclasses import dataclass

@dataclass
class CharacterProfile:
    name: str
    age: int
    appearance: str = ""

AGE_GROUPS = {
    "child": (6, 12),
    "teen": (13, 19),
    "adult": (20, 64),
    "elder": (65, 99),
}

def support_age_shift(profile: CharacterProfile, target_group: str) -> CharacterProfile:
    """Return a copy of ``profile`` shifted into ``target_group`` age range."""
    if target_group not in AGE_GROUPS:
        raise ValueError(f"Unknown age group: {target_group}")

    min_age, max_age = AGE_GROUPS[target_group]
    new_age = (min_age + max_age) // 2
    updated = CharacterProfile(name=profile.name, age=new_age, appearance=profile.appearance)
    return updated
