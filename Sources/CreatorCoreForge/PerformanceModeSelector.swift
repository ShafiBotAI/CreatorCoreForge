import Foundation

/// Selects performance presets that alter audio rendering characteristics.
public enum PerformanceMode: String, CaseIterable {
    case standard
    case balanced
    case cinematic
    case stealth
}

public final class PerformanceModeSelector {
    public private(set) var current: PerformanceMode

    public init(initial: PerformanceMode = .standard) {
        self.current = initial
    }

    /// Update the current performance mode.
    public func apply(_ mode: PerformanceMode) {
        current = mode
        print("⚙️ Performance mode set to \(mode.rawValue)")
    }
}
