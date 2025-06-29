import Foundation

/// Provides offline creative sandboxing with simple encoded saves.
public final class OfflineCreativeSandbox {
    private let directory: URL

    public init(directory: URL) {
        self.directory = directory
    }

    /// Save text using basic base64 "encryption".
    public func save(text: String, as name: String) throws {
        let data = Data(text.utf8).base64EncodedData()
        try data.write(to: directory.appendingPathComponent(name))
    }

    /// Load and decode saved text.
    public func load(name: String) -> String? {
        let url = directory.appendingPathComponent(name)
        guard let data = try? Data(contentsOf: url),
              let decoded = Data(base64Encoded: data) else { return nil }
        return String(data: decoded, encoding: .utf8)
    }
}
