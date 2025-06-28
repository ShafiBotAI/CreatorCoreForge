# Release Process – GitHub Flow

CreatorCoreForge has migrated from a trunk-based workflow to **GitHub Flow**. All changes now go through a pull request before merging into `main`.

## Steps

1. **Create a branch** for each feature or fix.
2. **Run the test suites** locally and in CI.
3. **Open a pull request** and request code review.
4. **Address feedback** until tests pass and approvals are granted.
5. **Merge** the pull request into `main`.
6. **Tag a release** from the `main` branch and publish binaries.

This process keeps `main` stable and ensures each release is well tested and reviewed.
