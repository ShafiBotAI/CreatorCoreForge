import Foundation

/// Represents a single filing document.
public struct Filing: Codable, Equatable {
    public var id: UUID
    public var title: String
    public var date: Date
    public var url: URL

    public init(id: UUID = UUID(), title: String, date: Date, url: URL) {
        self.id = id
        self.title = title
        self.date = date
        self.url = url
    }
}

/// Simple JSON-backed storage for `Filing` records.
public final class FilingsDatabase {
    private let fileURL: URL
    private let fileManager: FileManager
    private var filings: [Filing] = []

    public init(directory: URL? = nil, fileManager: FileManager = .default) {
        self.fileManager = fileManager
        let dir = directory ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = dir.appendingPathComponent("filings.json")
        load()
    }

    /// Persist a filing to disk.
    public func save(_ filing: Filing) throws {
        filings.append(filing)
        try persist()
    }

    /// Return all saved filings.
    public func list() -> [Filing] {
        filings
    }

    /// Remove all filings from storage.
    public func clear() throws {
        filings.removeAll()
        try persist()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([Filing].self, from: data) {
            filings = decoded
        }
    }

    private func persist() throws {
        let data = try JSONEncoder().encode(filings)
        try fileManager.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true)
        try data.write(to: fileURL, options: .atomic)
    }
}
