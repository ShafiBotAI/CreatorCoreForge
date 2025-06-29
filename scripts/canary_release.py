import os
import subprocess

THRESHOLD = float(os.getenv("ROLLBACK_THRESHOLD", "0.05"))
ERROR_RATE_FILE = os.getenv("ERROR_RATE_FILE", "logs/error_rate.txt")


def current_error_rate() -> float:
    try:
        with open(ERROR_RATE_FILE) as f:
            return float(f.read().strip())
    except FileNotFoundError:
        return 0.0


def main() -> None:
    rate = current_error_rate()
    print(f"Current error rate: {rate}")
    if rate > THRESHOLD:
        print("Threshold exceeded, triggering rollback")
        subprocess.call(["./scripts/universal_build.sh", "rollback"])
    else:
        print("Canary release healthy")


if __name__ == "__main__":
    main()
