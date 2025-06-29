import time

def busy_work(n: int) -> int:
    x = 0
    for i in range(n):
        x += (i * i) % 7
    return x

for _ in range(5):
    busy_work(10_000_000)
    time.sleep(0.1)
print("load test complete")
