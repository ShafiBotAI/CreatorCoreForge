# CreatorCoreForge Admin Onboarding

This guide explains how to set up a local environment and run core checks.

1. **Clone the repository** and install dependencies (Swift toolchain, Node.js).
2. **Run the test suites**:
   - `swift test`
   - `npm test` (within `VisualLab` and `VoiceLab` packages)
3. **Generate audit reports** with `python3 scripts/feature_audit.py .`.
4. **Review** `docs/OPEN_TASKS.md` for outstanding tasks.
5. **Follow CI guidelines** in `.github/workflows` when pushing changes.

New admins should also read `AGENTS.md` at the repo root for a full overview of
all app features and responsibilities.
