from hypothesis import given, strategies as st

def reverse_twice(s: str) -> str:
    return s[::-1][::-1]

@given(st.text())
def test_reverse_twice_identity(s):
    assert reverse_twice(s) == s
