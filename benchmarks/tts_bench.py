import time
import importlib

def bench(func, *args, **kwargs):
    start = time.perf_counter()
    func(*args, **kwargs)
    return time.perf_counter() - start

try:
    coqui = importlib.import_module('apps.ebook2audiobook.lib.classes.tts_engines.coqui')
    synth = getattr(coqui, 'synthesize', lambda text: None)
except Exception:
    def synth(text):
        time.sleep(0.01)

if __name__ == '__main__':
    duration = bench(synth, 'hello world')
    print(f'TTS benchmark: {duration:.3f}s')
