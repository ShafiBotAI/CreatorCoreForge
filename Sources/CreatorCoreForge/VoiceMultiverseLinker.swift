#if canImport(Combine)
import Foundation
import Combine

/// Links voice IDs across different projects and contexts for reuse.
public final class VoiceMultiverseLinker: ObservableObject {
    /// Shared singleton instance.
    public static let shared = VoiceMultiverseLinker()

    /// Represents a link between two voice identifiers and associated context.
    public struct VoiceLink: Identifiable, Codable {
        public var id: UUID = UUID()
        public var sourceVoiceID: String
        public var linkedVoiceID: String
        public var projectContext: String
        public var reason: String
        public init(sourceVoiceID: String, linkedVoiceID: String, projectContext: String, reason: String) {
            self.sourceVoiceID = sourceVoiceID
            self.linkedVoiceID = linkedVoiceID
            self.projectContext = projectContext
            self.reason = reason
        }
    }

    @Published private(set) public var links: [VoiceLink] = []

    /// Create a link between two voices.
    public func linkVoices(source: String, linked: String, project: String, reason: String) {
        let link = VoiceLink(sourceVoiceID: source, linkedVoiceID: linked, projectContext: project, reason: reason)
        links.append(link)
    }

    /// Convenience helper to link voices using default context.
    public func linkVoices(primaryID: String, secondaryID: String) {
        linkVoices(source: primaryID, linked: secondaryID, project: "global", reason: "direct link")
    }

    /// Return all links associated with the given voice ID as source or target.
    public func getLinks(for voiceID: String) -> [VoiceLink] {
        links.filter { $0.sourceVoiceID == voiceID || $0.linkedVoiceID == voiceID }
    }

    /// Remove a link with the provided identifier.
    public func removeLink(_ id: UUID) {
        links.removeAll { $0.id == id }
    }

    /// Remove all stored links.
    public func clearAll() {
        links.removeAll()
    }
}
#else
import Foundation

public final class VoiceMultiverseLinker {
    public static let shared = VoiceMultiverseLinker()

    public struct VoiceLink: Identifiable, Codable {
        public var id: UUID = UUID()
        public var sourceVoiceID: String
        public var linkedVoiceID: String
        public var projectContext: String
        public var reason: String
        public init(sourceVoiceID: String, linkedVoiceID: String, projectContext: String, reason: String) {
            self.sourceVoiceID = sourceVoiceID
            self.linkedVoiceID = linkedVoiceID
            self.projectContext = projectContext
            self.reason = reason
        }
    }

    public private(set) var links: [VoiceLink] = []

    public func linkVoices(source: String, linked: String, project: String, reason: String) {
        let link = VoiceLink(sourceVoiceID: source, linkedVoiceID: linked, projectContext: project, reason: reason)
        links.append(link)
    }

    /// Convenience helper to link voices using default context.
    public func linkVoices(primaryID: String, secondaryID: String) {
        linkVoices(source: primaryID, linked: secondaryID, project: "global", reason: "direct link")
    }

    public func getLinks(for voiceID: String) -> [VoiceLink] {
        links.filter { $0.sourceVoiceID == voiceID || $0.linkedVoiceID == voiceID }
    }

    public func removeLink(_ id: UUID) {
        links.removeAll { $0.id == id }
    }

    public func clearAll() {
        links.removeAll()
    }
}
#endif
