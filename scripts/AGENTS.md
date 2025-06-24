# Agent: Build Script Maintenance

## Directory: scripts
Purpose: Utility scripts for building and auditing CreatorCoreForge

### Tasks
- [x] Keep bash and Python scripts cross-platform
- [x] Ensure templates generate valid pbxproj files
- [x] Expand feature audit logic
- [x] List admin script execution steps

---

## Codex/AI Agent Note
Scripts should be tested regularly on all platforms.

### Phase Features Summary
Key points from `README.md`:
- `chatterbox_bridge.py` – convert a simple `SPEAKER: line` script into a single audio file using a Chatterbox API. Requires `pydub`, `tqdm`, `requests`, and a `CHATTERBOX_API_URL` environment variable.
- `fetch_plugins.sh` – download plugin repositories listed in `plugin_list.txt` using `pull_plugins.py`.

