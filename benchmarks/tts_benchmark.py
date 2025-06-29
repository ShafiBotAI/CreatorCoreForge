import timeit

def synthesize(text: str) -> str:
    # placeholder for TTS function
    return text[::-1]

def bench():
    setup = "from __main__ import synthesize"
    stmt = "synthesize('hello world')"
    duration = timeit.timeit(stmt, setup=setup, number=1000)
    print(f"TTS benchmark: {duration:.4f}s")

if __name__ == '__main__':
    bench()
