import Foundation

/// Convenience wrapper around `VoiceDNAForker` to manage custom clone variations.
public final class VoiceForkManager {
    private let forker = VoiceDNAForker.shared

    public init() {}

    @discardableResult
    public func createFork(baseID: String, name: String, pitch: Float, speed: Float, tone: String) -> VoiceDNAForker.VoiceVariant {
        forker.createVariant(from: baseID, name: name, pitch: pitch, speed: speed, tone: tone)
        return forker.getVariants(for: baseID).last!
    }

    public func allForks(for baseID: String) -> [VoiceDNAForker.VoiceVariant] {
        forker.getVariants(for: baseID)
    }
}
