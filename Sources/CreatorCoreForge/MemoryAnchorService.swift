import Foundation

/// Stores memory anchors that reference important scenes or events.
public final class MemoryAnchorService {
    public struct Anchor: Codable, Equatable {
        public let id: UUID
        public let description: String
        public init(id: UUID = UUID(), description: String) {
            self.id = id
            self.description = description
        }
    }

    private let fileURL: URL
    private var anchors: [Anchor] = []

    public init(fileURL: URL? = nil) {
        if let url = fileURL {
            self.fileURL = url
        } else {
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            self.fileURL = dir.appendingPathComponent("anchors.json")
        }
        load()
    }

    /// Create and persist a new memory anchor.
    @discardableResult
    public func createAnchor(description: String) -> Anchor {
        let anchor = Anchor(description: description)
        anchors.append(anchor)
        save()
        return anchor
    }

    /// Return all stored anchors.
    public func allAnchors() -> [Anchor] { anchors }

    /// Remove all anchors from storage.
    public func clear() {
        anchors.removeAll()
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Anchor].self, from: data) {
            anchors = decoded
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(anchors) {
            try? data.write(to: fileURL)
        }
    }
}
