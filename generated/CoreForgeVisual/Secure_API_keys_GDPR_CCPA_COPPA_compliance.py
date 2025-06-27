# Auto-generated for Secure API keys, GDPR/CCPA/COPPA compliance
def secure_api_keys(key: str) -> str:
    """Return a redacted version of an API key for logging."""
    if len(key) <= 4:
        return "***"
    return key[:2] + "***" + key[-2:]
