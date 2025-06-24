import Foundation

/// Tracks voice DNA links and forks across different universes/projects.
public final class VoiceMultiverseManager {
    public static let shared = VoiceMultiverseManager()

    private let linker = VoiceMultiverseLinker.shared
    private let forker = VoiceDNAForker.shared

    private init() {}

    /// Creates a variant and links it with a given context.
    public func createFork(baseID: String, name: String, context: String) -> VoiceDNAForker.VoiceVariant {
        forker.createVariant(from: baseID, name: name, pitch: 0, speed: 0, tone: "")
        let variant = forker.getVariants(for: baseID).last!
        linker.linkVoices(source: baseID, linked: variant.id.uuidString, project: context, reason: "fork")
        return variant
    }

    /// Returns all linked variants for a base voice.
    public func variants(for baseID: String) -> [VoiceDNAForker.VoiceVariant] {
        linker.getLinks(for: baseID).compactMap { link in
            UUID(uuidString: link.linkedVoiceID).flatMap { id in
                forker.variants.first { $0.id == id }
            }
        }
    }
}
