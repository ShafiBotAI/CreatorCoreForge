import Foundation

/// Service responsible for linking character DNA across apps and persisting
/// the connections locally so other modules can read them.
public class MemoryLinkService {
    private var linkedIDs: Set<String> = []
    private let fileURL: URL

    public init(directory: URL = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first!) {
        self.fileURL = directory.appendingPathComponent("memoryLinks.json")
        load()
    }

    public func link(id: String) {
        linkedIDs.insert(id)
        save()
    }

    public func isLinked(id: String) -> Bool {
        return linkedIDs.contains(id)
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let ids = try? JSONDecoder().decode([String].self, from: data) else { return }
        linkedIDs = Set(ids)
    }

    private func save() {
        let data = try? JSONEncoder().encode(Array(linkedIDs))
        try? data?.write(to: fileURL)
    }
}
