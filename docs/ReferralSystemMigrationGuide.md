# Referral System Migration Guide

This guide explains how to update existing CoreForge Audio apps to the new referral system. It covers Swift code changes, `@AppStorage` usage, UI additions, and notes for App Store Connect and backend configuration.

## Overview

The new referral workflow tracks signups and rewards users with in‑app credits. Referral codes are generated per user and persisted with `@AppStorage`. The `ReferralManager` singleton handles code creation, reward tracking, and credit allocation.

### Key Files

- `apps/CoreForgeAudio/VocalVerseFull/VocalVerse/ReferralManager.swift`
- `apps/CoreForgeAudio/VocalVerseFull/VocalVerse/ReferralView.swift`
- `Sources/CreatorCoreForge/ReferralProgram.swift`
- `Sources/CreatorCoreForge/ReferralDashboard.swift`

## Swift Integration Steps

1. **Persist User Codes**
   Add the following property to any view model or manager that needs the current referral code:
   ```swift
   @AppStorage("referralCode") var referralCode: String = ""
   ```
   This ensures the code is retained across launches and accessible anywhere in the app.

2. **Generate and Share Codes**
   Use `ReferralManager.shared.myCode()` to produce a unique code. Display it in a dedicated view, such as `ReferralView`, and provide a `ShareLink` or share sheet for easy distribution.

3. **Register Sign‑ups**
   When a new user signs up via a referral link, store the incoming code in `@AppStorage("referralCode")` before account creation. Call `ReferralProgram.shared.registerSignup(code:)` or update your backend accordingly.

4. **Reward the Referrer**
   After the referred user completes a paid upgrade, trigger:
   ```swift
   ReferralManager.shared.rewardReferrer(for: plan)
   ```
   The manager updates stored credits and publishes `lastReward` for UI pop‑ups.

5. **Credit Tracking**
   Store total credits earned through referrals using:
   ```swift
   @AppStorage("creditsEarnedFromReferral") var credits: Int = 0
   ```
   Increment this value whenever `rewardReferrer` succeeds.

6. **UI Updates**
   - Present `ReferralView()` from your profile or settings screen.
   - Show a banner when `ReferralManager.shared.lastReward` becomes non‑`nil`.
   - Display accumulated referral credits in `SettingsView` using the above `@AppStorage` binding.

## App Store Connect & Backend Steps

1. **Configure Universal Links**
   Register a URL (e.g., `https://example.com/ref/<code>`) that opens the app and fills the referral field during registration.
2. **StoreKit Notes**
   No separate IAP is required, but ensure promotional credits do not violate App Store review guidelines. Keep your in‑app purchases up to date in App Store Connect.
3. **Server Logging**
   If using a backend, log referral signups and rewards to keep records in sync across devices. `docs/AppStore_Compliance.md` lists privacy notes that also apply to referral data.

## Open Tasks

See the repository for open items related to subscriptions, referrals, and credits:
- [docs/PHASE_NINE.md](PHASE_NINE.md) – roadmap for upcoming features.
- [docs/OPEN_TASKS.md](OPEN_TASKS.md) – summary of remaining work across the apps.

Complete these tasks to finalize referral integration and ensure dashboard reporting matches the new logic.

