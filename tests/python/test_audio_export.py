import unittest
from pydub.generators import Sine
from pydub import AudioSegment
import sys
from pathlib import Path

# Ensure the generated modules are discoverable when running tests locally.
sys.path.append(str(Path(__file__).resolve().parents[2]))

from generated.CoreForgeAudio.MultiTrackExport import multitrack_export
from generated.CoreForgeAudio.VoiceApprovalWorkflow import VoiceSegment, approve_segment, reject_segment, summary
import os
import tempfile

class MultiTrackExportTests(unittest.TestCase):
    def test_export_and_archive(self):
        tracks = {
            "a": Sine(440).to_audio_segment(duration=100),
            "b": Sine(880).to_audio_segment(duration=100),
        }
        with tempfile.TemporaryDirectory() as tmp:
            out = multitrack_export(tracks, tmp, archive=True)
            self.assertTrue(os.path.isfile(out))

class VoiceApprovalWorkflowTests(unittest.TestCase):
    def test_approve_reject_summary(self):
        s1 = VoiceSegment("1", "a.wav")
        s2 = VoiceSegment("2", "b.wav")
        approve_segment(s1, "good")
        reject_segment(s2)
        stats = summary([s1, s2])
        self.assertEqual(stats["approved"], 1)
        self.assertEqual(stats["rejected"], 1)
        self.assertIn("good", s1.notes)

if __name__ == '__main__':
    unittest.main()
