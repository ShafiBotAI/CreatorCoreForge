import Foundation

/// Logger that writes structured JSON lines and scrubs sensitive values.
public final class JSONLogger {
    private let fileURL: URL
    private let queue = DispatchQueue(label: "json.logger.queue")

    public init(directory: URL? = nil) {
        let dir = directory ?? FileManager.default.temporaryDirectory
        self.fileURL = dir.appendingPathComponent("events.jsonl")
    }

    /// Record an event with optional metadata. Keys containing `token` or `password`
    /// have their values replaced with `***` before writing.
    public func log(event: String, metadata: [String: String] = [:]) {
        queue.async {
            var sanitized = metadata
            for key in sanitized.keys {
                if key.lowercased().contains("token") || key.lowercased().contains("password") {
                    sanitized[key] = "***"
                }
            }
            var record: [String: Any] = [
                "timestamp": ISO8601DateFormatter().string(from: Date()),
                "event": event
            ]
            sanitized.forEach { record[$0.key] = $0.value }
            guard let data = try? JSONSerialization.data(withJSONObject: record) else { return }
            if FileManager.default.fileExists(atPath: self.fileURL.path) {
                if let handle = try? FileHandle(forWritingTo: self.fileURL) {
                    handle.seekToEndOfFile()
                    handle.write(data)
                    handle.write(Data("\n".utf8))
                    handle.closeFile()
                }
            } else {
                try? (String(data: data, encoding: .utf8)! + "\n").write(to: self.fileURL, atomically: true, encoding: .utf8)
            }
        }
    }
}
