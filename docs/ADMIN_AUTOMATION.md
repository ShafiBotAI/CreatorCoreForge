# Admin Automation Guidelines

This document lists recommended automation practices for maintaining CreatorCoreForge.

## Workflow Overview
- Use the provided GitHub Actions workflows for tests and linting.
- Run `scripts/progress_bot.py` after updates to track feature completion.
- Use `scripts/feature_audit.py` to generate audit reports before releases.

## Script Execution Steps
1. **Run progress checks**
   ```bash
   python scripts/progress_bot.py
   ```
2. **Generate feature audit**
   ```bash
   python3 scripts/feature_audit.py .
   ```
3. **Run Swift and JavaScript tests**
   ```bash
   swift test
   npm test --workspaces
   ```

These steps help admins maintain consistent automation across all apps.
