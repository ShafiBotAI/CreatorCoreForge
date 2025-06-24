import Foundation

/// Persist and load character trait information to disk in JSON format.
public final class TraitMemoryPersistence {
    private let fileURL: URL
    private var traits: [String: [String: String]] = [:]
    private let queue = DispatchQueue(label: "TraitMemoryPersistenceQueue")

    /// Initialize with optional storage URL. Defaults to Documents directory.
    public init(fileURL: URL? = nil) {
        if let url = fileURL {
            self.fileURL = url
        } else {
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            self.fileURL = dir.appendingPathComponent("traits.json")
        }
        load()
    }

    /// Set a trait value for the given character and persist to disk.
    public func setTrait(_ trait: String, value: String, for character: String) {
        queue.sync {
            var map = traits[character.lowercased()] ?? [:]
            map[trait] = value
            traits[character.lowercased()] = map
            save()
        }
    }

    /// Retrieve a trait value for a character.
    public func trait(_ trait: String, for character: String) -> String? {
        queue.sync {
            traits[character.lowercased()]?[trait]
        }
    }

    /// Retrieve all traits for a character.
    public func traits(for character: String) -> [String: String] {
        queue.sync { traits[character.lowercased()] ?? [:] }
    }

    /// Clear all stored traits.
    public func clear() {
        queue.sync {
            traits.removeAll()
            save()
        }
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([String: [String: String]].self, from: data) {
            traits = decoded
        }
    }

    private func save() {
        let data = try? JSONEncoder().encode(traits)
        try? data?.write(to: fileURL)
    }
}
