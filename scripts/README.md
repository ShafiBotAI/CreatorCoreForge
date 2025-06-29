# Scripts

Utility shell and Python scripts used for building projects and auditing features. See each script for details.

- `chatterbox_bridge.py` – convert a simple `SPEAKER: line` script into a single audio file using a Chatterbox API. Requires `pydub`, `tqdm`, `requests`, and a `CHATTERBOX_API_URL` environment variable.
- `fetch_plugins.sh` – download plugin repositories listed in `plugin_list.txt` using `pull_plugins.py`.
- `fetch_n8n.sh` – clone the n8n automation engine into `external/n8n`.
- `fetch_audiobookshelf.sh` – clone the audiobookshelf server into `external/audiobookshelf`.

- `pull_plugins.py` – download a GitHub repository; automatically falls back to the `main` branch if `master` is missing.
  The list now points to publicly accessible GitHub repositories so the script
  can be run without errors. `pull_plugins.py` will try both `master` and `main`
  branches when downloading.

- `export_coreforge_audio_repo.sh` – copy the CoreForge Audio app and shared
  Swift sources into a standalone directory, optionally initializing a new git
  repository.
