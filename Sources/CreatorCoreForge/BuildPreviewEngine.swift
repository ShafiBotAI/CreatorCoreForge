import Foundation

/// Provides live preview, debugging, and testing utilities for CoreForge Build.
public final class BuildPreviewEngine {
    public static let shared = BuildPreviewEngine()
    private var logs: [String] = []
    private init() {}

    /// Start a simulated preview for the given platform.
    @discardableResult
    public func startPreview(platform: String) -> String {
        let msg = "Preview started for \(platform)"
        logEvent(msg)
        return msg
    }

    /// Record a log entry that can be displayed in real time.
    public func logEvent(_ message: String) {
        logs.append(message)
    }

    /// Current log history.
    public func currentLogs() -> [String] {
        logs
    }

    /// Inject mock data into the preview environment.
    public func injectMockData(_ data: [String: Any]) {
        logEvent("Injected mock data: \(data.keys.joined(separator: ","))")
    }

    /// Simple performance metrics placeholder.
    public func performanceMetrics() -> [String: Double] {
        ["loadTime": 1.0, "memory": 100.0, "fps": 60.0]
    }
}
