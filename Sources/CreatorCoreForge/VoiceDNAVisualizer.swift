import Foundation

/// Represents a node in the voice DNA tree.
public struct VoiceDNANode: Codable, Equatable {
    public var profile: VoiceProfile
    public var parentID: String?
    public init(profile: VoiceProfile, parentID: String? = nil) {
        self.profile = profile
        self.parentID = parentID
    }
}

/// Visualizes and exports relationships between voice profiles.
public final class VoiceDNAVisualizer {
    private var nodes: [String: VoiceDNANode] = [:]
    private var usage: [String: [Date]] = [:]
    private let engine: LocalAIEnginePro

    public init(engine: LocalAIEnginePro = LocalAIEnginePro()) {
        self.engine = engine
    }

    /// Add a new voice profile to the graph.
    public func addVoice(_ profile: VoiceProfile, parentID: String? = nil) {
        nodes[profile.id] = VoiceDNANode(profile: profile, parentID: parentID)
    }

    /// Create or update a parent link for an existing voice.
    public func link(childID: String, to parentID: String) {
        guard var node = nodes[childID] else { return }
        node.parentID = parentID
        nodes[childID] = node
    }

    /// Record a usage timestamp for the provided voice ID.
    public func recordUsage(voiceID: String, at date: Date = Date()) {
        usage[voiceID, default: []].append(date)
    }

    /// Returns all child voices forked from the given parent ID.
    public func children(of parentID: String) -> [VoiceDNANode] {
        return nodes.values.filter { $0.parentID == parentID }
    }

    /// Return the usage timeline for a given voice ID.
    public func usageTimeline(for voiceID: String) -> [Date] {
        return usage[voiceID] ?? []
    }

    /// Export the entire voice tree and usage data as JSON.
    public func exportJSON() -> Data? {
        struct Payload: Codable { let nodes: [VoiceDNANode]; let usage: [String: [Date]] }
        return try? JSONEncoder().encode(Payload(nodes: Array(nodes.values), usage: usage))
    }

    /// Generates a dictionary mapping each voice ID to an embedding vector.
    /// This forms the Vector Voice DNA Map used by the visualizer.
    public func vectorVoiceDNAMap(completion: @escaping ([String: [Double]]) -> Void) {
        let group = DispatchGroup()
        var result: [String: [Double]] = [:]
        for node in nodes.values {
            group.enter()
            let text = node.profile.name + " " + node.profile.emotion
            engine.sendEmbeddingRequest(text: text) { res in
                if case .success(let vector) = res {
                    result[node.profile.id] = vector
                }
                group.leave()
            }
        }
        group.notify(queue: .main) { completion(result) }
    }
}
