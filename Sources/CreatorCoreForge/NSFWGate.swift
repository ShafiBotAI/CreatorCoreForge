import Foundation

/// Middleware to filter text segments based on NSFW gating and PIN verification.
public struct NSFWGate {
    private let verifier: AgeIDVerifier
    private let vault: StealthModeVaultManager

    public init(verifier: AgeIDVerifier = AgeIDVerifier(),
                vault: StealthModeVaultManager = StealthModeVaultManager()) {
        self.verifier = verifier
        self.vault = vault
    }

    /// Filter segments when NSFW content is locked or PIN invalid.
    public func filterSegments(_ segments: [Segment], pin: String?) -> [Segment] {
        guard verifier.isVerified || (pin != nil && vault.verifyPIN(pin!)) else {
            return segments.filter { _ in false }
        }
        return segments
    }
}
