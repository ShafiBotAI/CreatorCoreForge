import sys, os; sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
import unittest
from pathlib import Path

from CoreForgeBuild.OfflineMP3Downloader import download_mp3
from CoreForgeBuild.SmartBuildService003 import optimize_project
from CoreForgeBuild.DynamicBuildToolkit004 import apply_toolchain
from CoreForgeBuild.AutomatedBuildSystem005 import run_build
from CoreForgeBuild.EnhancedBuildInterface006 import status_message

class BuildFeatureModuleTests(unittest.TestCase):
    def test_download_mp3_creates_file(self):
        path = download_mp3('example.com/test.mp3', 'tmp_test.mp3')
        self.assertTrue(Path(path).exists())
        Path(path).unlink()

    def test_optimize_project_message(self):
        result = optimize_project('.')
        self.assertIn('Optimized', result)

    def test_apply_toolchain(self):
        result = apply_toolchain(['a', 'b'])
        self.assertEqual(result, ['apply:a', 'apply:b'])

    def test_run_build(self):
        result = run_build(['ios', 'android'])
        self.assertEqual(result, {'ios': True, 'android': True})

    def test_status_message(self):
        self.assertEqual(status_message('ok'), 'Build status: ok')

if __name__ == '__main__':
    unittest.main()
