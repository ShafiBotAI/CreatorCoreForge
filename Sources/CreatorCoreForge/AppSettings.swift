import Foundation
#if canImport(Combine)
import Combine

/// Stores global settings including NSFW access, offline mode, and performance quality.
public final class AppSettings: ObservableObject {
    public static let shared = AppSettings()

    @Published public var allowNSFW: Bool
    @Published public var offlineMode: Bool
    @Published public var performance: PerformanceMode

    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.allowNSFW = defaults.bool(forKey: "CF_allowNSFW")
        self.offlineMode = defaults.bool(forKey: "CF_offlineMode")
        if let raw = defaults.string(forKey: "CF_performanceMode"),
           let mode = PerformanceMode(rawValue: raw) {
            self.performance = mode
        } else {
            self.performance = .standard
        }
    }

    /// Persist the current settings to user defaults.
    public func save() {
        defaults.set(allowNSFW, forKey: "CF_allowNSFW")
        defaults.set(offlineMode, forKey: "CF_offlineMode")
        defaults.set(performance.rawValue, forKey: "CF_performanceMode")
    }
}
#else
/// Stores global settings including NSFW access, offline mode, and performance quality.
public final class AppSettings {
    public static let shared = AppSettings()

    public var allowNSFW: Bool
    public var offlineMode: Bool
    public var performance: PerformanceMode

    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.allowNSFW = defaults.bool(forKey: "CF_allowNSFW")
        self.offlineMode = defaults.bool(forKey: "CF_offlineMode")
        if let raw = defaults.string(forKey: "CF_performanceMode"),
           let mode = PerformanceMode(rawValue: raw) {
            self.performance = mode
        } else {
            self.performance = .standard
        }
    }

    public func save() {
        defaults.set(allowNSFW, forKey: "CF_allowNSFW")
        defaults.set(offlineMode, forKey: "CF_offlineMode")
        defaults.set(performance.rawValue, forKey: "CF_performanceMode")
    }
}
#endif
