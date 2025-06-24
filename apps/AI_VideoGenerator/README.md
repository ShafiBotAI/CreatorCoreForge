# AI Video Generator

This is an excerpt from the open source [ai-video-generator](https://github.com/Endergr/ai-video-generator) repository. It demonstrates how to run a FastAPI backend for generating AI-driven videos. Only the server file and MIT license are included here for reference.

## Ultra Long Video Assembly

For producing seamless ultra-long videos, use the `scripts/ultra_long_video_assembler.py` utility. Generate individual segments with the server and then pass them to the script:

```bash
python ../../scripts/ultra_long_video_assembler.py output.mp4 segment1.mp4 segment2.mp4 segment3.mp4
```

This uses `ffmpeg` under the hood to concatenate the segments without re-encoding.
