from pydub.generators import Sine
from pydub import AudioSegment
import sys
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(SCRIPT_DIR, "..", "generated", "CoreForgeAudio"))
from Support_multiverse_collapse_audio_effect_when_timelines_converge import support_multiverse_collapse

def main(out_file: str) -> None:
    tone_a = Sine(440).to_audio_segment(duration=1000)
    tone_b = Sine(880).to_audio_segment(duration=1000)
    tone_a.export('a.wav', format='wav')
    tone_b.export('b.wav', format='wav')
    support_multiverse_collapse('a.wav', 'b.wav', out_file, duration_ms=500, out_format='wav')
    os.remove('a.wav')
    os.remove('b.wav')

if __name__ == '__main__':
    main(sys.argv[1])
