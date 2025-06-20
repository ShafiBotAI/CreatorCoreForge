#if canImport(Combine)
import Combine
import Foundation

/// Forks a base voice profile into distinct variations.
public final class VoiceDNAForker: ObservableObject {
    /// Shared singleton instance.
    public static let shared = VoiceDNAForker()

    /// Represents a single voice variant.
    public struct VoiceVariant: Identifiable, Codable {
        public var id: UUID = UUID()
        public var baseVoiceID: String
        public var variantName: String
        public var pitchDelta: Float  // e.g., -0.2 to +0.2
        public var speedDelta: Float  // e.g., -0.1 to +0.2
        public var toneModifier: String  // "calm", "excited", etc.
    }

    /// Stored voice variants.
    @Published public private(set) var variants: [VoiceVariant] = []

    public init() {}

    /// Create and store a voice variant from a base profile.
    public func createVariant(from baseID: String,
                              name: String,
                              pitch: Float,
                              speed: Float,
                              tone: String) {
        let variant = VoiceVariant(baseVoiceID: baseID,
                                   variantName: name,
                                   pitchDelta: pitch,
                                   speedDelta: speed,
                                   toneModifier: tone)
        variants.append(variant)
    }

    /// Return all variants for the given base voice ID.
    public func getVariants(for baseID: String) -> [VoiceVariant] {
        variants.filter { $0.baseVoiceID == baseID }
    }

    /// Delete a voice variant by identifier.
    public func deleteVariant(_ id: UUID) {
        variants.removeAll { $0.id == id }
    }

    /// Remove all stored variants.
    public func clearAllVariants() {
        variants.removeAll()
    }
}
#else
import Foundation

/// Non-observable fallback when Combine is unavailable.
public final class VoiceDNAForker {
    public static let shared = VoiceDNAForker()

    public struct VoiceVariant: Identifiable, Codable {
        public var id: UUID = UUID()
        public var baseVoiceID: String
        public var variantName: String
        public var pitchDelta: Float
        public var speedDelta: Float
        public var toneModifier: String
    }

    private(set) var variants: [VoiceVariant] = []

    public init() {}

    public func createVariant(from baseID: String,
                              name: String,
                              pitch: Float,
                              speed: Float,
                              tone: String) {
        let variant = VoiceVariant(baseVoiceID: baseID,
                                   variantName: name,
                                   pitchDelta: pitch,
                                   speedDelta: speed,
                                   toneModifier: tone)
        variants.append(variant)
    }

    public func getVariants(for baseID: String) -> [VoiceVariant] {
        variants.filter { $0.baseVoiceID == baseID }
    }

    public func deleteVariant(_ id: UUID) {
        variants.removeAll { $0.id == id }
    }

    public func clearAllVariants() {
        variants.removeAll()
    }
}
#endif
