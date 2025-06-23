# Scripts

Utility shell and Python scripts used for building projects and auditing features. See each script for details.

- `chatterbox_bridge.py` – convert a simple `SPEAKER: line` script into a single audio file using a Chatterbox API. Requires `pydub`, `tqdm`, `requests`, and a `CHATTERBOX_API_URL` environment variable.
- `fetch_plugins.sh` – download plugin repositories listed in `plugin_list.txt` using `pull_plugins.py`.
- `pull_plugins.py` – download a GitHub repository; automatically falls back to the `main` branch if `master` is missing.
