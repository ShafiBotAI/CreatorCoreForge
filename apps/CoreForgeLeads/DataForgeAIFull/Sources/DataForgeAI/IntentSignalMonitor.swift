import Foundation

/// Monitors intent signals from various social sources.
public final class IntentSignalMonitor {
    private var sources: [URL] = []
    private var capturedSignals: [String] = []

    public init() {}

    /// Add a new intent signal source URL.
    public func addSource(_ url: URL) {
        sources.append(url)
    }

    /// Poll all sources and capture new signals. This is a simple stub that
    /// simulates network polling by reading the URL contents if possible.
    public func poll() {
        for url in sources {
            if let data = try? String(contentsOf: url).split(separator: "\n") {
                capturedSignals.append(contentsOf: data.map(String.init))
            }
        }
    }

    /// Latest captured signals.
    public func latest(limit: Int) -> [String] {
        Array(capturedSignals.suffix(limit))
    }
}
