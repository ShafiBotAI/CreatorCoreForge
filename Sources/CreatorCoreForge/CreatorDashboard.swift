import Foundation

/// Stores global feature toggles for the Creator Dashboard across all apps.
public final class CreatorDashboard {
    public static let shared = CreatorDashboard()

    /// Feature flags controlled by promo codes or user settings.
    public struct Features: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }

        public static let voiceMemoryControl = Features(rawValue: 1 << 0)
        public static let emotionGraphs      = Features(rawValue: 1 << 1)
        public static let pluginBuilder      = Features(rawValue: 1 << 2)
        public static let aiStudioMode       = Features(rawValue: 1 << 3)
        public static let genesisMode        = Features(rawValue: 1 << 4)
        /// Unlocks all Creator-tier features across apps.
        public static let globalUnlock       = Features(rawValue: 1 << 5)
        /// Enables sandbox and experimental modules for power users.
        public static let sandboxTools       = Features(rawValue: 1 << 6)
    }

    private let key = "CreatorDashboardFeatures"
    private let store: UserDefaults
    private var features: Features
    public init(store: UserDefaults = .standard) {
        self.store = store
        if let value = store.object(forKey: key) as? Int {
            features = Features(rawValue: value)
        } else {
            features = []
        }

        // Auto-enable Creator Tier features when promo code is redeemed.
        if PromoCodeManager.shared.hasCreatorAccess {
            enableAll()
        }
    }

    /// Enable specific features and persist the selection.
    public func enable(_ newFeatures: Features) {
        features.insert(newFeatures)
        persist()
    }

    /// Disable specific features and persist the selection.
    public func disable(_ oldFeatures: Features) {
        features.subtract(oldFeatures)
        persist()
    }

    /// Returns `true` if the given feature is enabled.
    public func isEnabled(_ feature: Features) -> Bool {
        features.contains(feature)
    }

    /// Enable all dashboard features.
    public func enableAll() {
        features = [
            .voiceMemoryControl,
            .emotionGraphs,
            .pluginBuilder,
            .aiStudioMode,
            .genesisMode,
            .globalUnlock,
            .sandboxTools
        ]
        persist()
    }

    private func persist() {
        store.set(features.rawValue, forKey: key)
    }
}
