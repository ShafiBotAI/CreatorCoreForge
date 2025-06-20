import Foundation

/// Lightweight analytics logger that records events to a file for later review.
public final class AnalyticsLogger {
    private let fileURL: URL
    private let queue = DispatchQueue(label: "analytics.logger.queue")

    public init(directory: URL? = nil) {
        let dir = directory ?? FileManager.default.temporaryDirectory
        self.fileURL = dir.appendingPathComponent("analytics.log")
    }

    /// Appends a timestamped line to the log file.
    public func log(event: String) {
        queue.async {
            let line = "\(Date()): \(event)\n"
            if FileManager.default.fileExists(atPath: self.fileURL.path) {
                if let handle = try? FileHandle(forWritingTo: self.fileURL) {
                    handle.seekToEndOfFile()
                    handle.write(Data(line.utf8))
                    handle.closeFile()
                }
            } else {
                try? line.write(to: self.fileURL, atomically: true, encoding: .utf8)
            }
        }
    }
}
