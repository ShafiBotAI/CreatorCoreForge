# Developer Setup

- Install Xcode and open `CoreForgeAudio.xcodeproj`
- Run `swift package resolve` to fetch dependencies
- Provide `OPENAI_API_KEY` and `ELEVEN_API_KEY` in your scheme
- Optional: `pip install -r ../ebook2audiobook/requirements.txt` to enable
  the ebook2audiobook pipeline used by `scripts/ebook2audiobook_bridge.py` or
  the `convert_ebook_to_audio` helper in `audio_utils.py`.
