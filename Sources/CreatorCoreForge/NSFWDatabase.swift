import Foundation

/// Global NSFW entry used across all apps.
public struct NSFWEntry: Codable, Identifiable {
    public enum ContentType: String, Codable {
        case text, audio, video, image
    }

    public var id: UUID = UUID()
    public var label: String
    public var type: ContentType
    public var tags: [String]
    public var timestamp: Date
    public var filePath: String?
    public var notes: String?
}

/// Lightweight JSON-backed database for NSFW entries.
public final class NSFWDatabase {
    public static let shared = NSFWDatabase()

    private var entries: [NSFWEntry] = []
    private let syncQueue = DispatchQueue(label: "nsfw.database.queue", attributes: .concurrent)
    private let storeURL: URL

    public init(directory: URL? = nil) {
        let fm = FileManager.default
        let dir = directory ?? fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        storeURL = dir.appendingPathComponent("nsfw_db.json")
        loadFromDisk()
    }

    /// Add a new NSFW entry and persist it to disk.
    public func add(_ entry: NSFWEntry) {
        syncQueue.async(flags: .barrier) {
            self.entries.append(entry)
            self.saveToDisk()
        }
    }

    /// Return all stored entries.
    public func all() -> [NSFWEntry] {
        var result: [NSFWEntry] = []
        syncQueue.sync { result = entries }
        return result
    }

    /// Search stored entries by keyword in label or tags.
    public func search(_ keyword: String) -> [NSFWEntry] {
        let lower = keyword.lowercased()
        var result: [NSFWEntry] = []
        syncQueue.sync {
            result = entries.filter { entry in
                entry.label.lowercased().contains(lower) ||
                entry.tags.contains(where: { $0.lowercased().contains(lower) })
            }
        }
        return result
    }

    private func saveToDisk() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        try? data.write(to: storeURL, options: .atomic)
    }

    private func loadFromDisk() {
        if let data = try? Data(contentsOf: storeURL),
           let arr = try? JSONDecoder().decode([NSFWEntry].self, from: data) {
            entries = arr
        } else {
            entries = []
        }
    }
}

