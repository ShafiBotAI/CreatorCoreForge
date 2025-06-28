import Foundation
#if canImport(Combine)
import Combine
#endif

/// Tracks app-wide voice usage and exposes daily top voices.
public final class AppFavoriteVoiceService: ObservableObject {
    public static let shared = AppFavoriteVoiceService()

    @Published public private(set) var dailyTopVoiceIDs: [String]

    private let usageKey = "AFV_Usage"
    private let topKey = "AFV_Top"
    private let dateKey = "AFV_Last"
    private var usage: [String: Int]
    private var lastUpdate: Date
    private let store: UserDefaults

    public init(store: UserDefaults = .standard) {
        self.store = store
        self.usage = store.dictionary(forKey: usageKey) as? [String: Int] ?? [:]
        self.dailyTopVoiceIDs = store.array(forKey: topKey) as? [String] ?? []
        self.lastUpdate = store.object(forKey: dateKey) as? Date ?? Date()
        updateIfNeeded(for: Date())
    }

    /// Record a voice usage event.
    public func recordUsage(voiceID: String) {
        updateIfNeeded(for: Date())
        usage[voiceID, default: 0] += 1
        store.set(usage, forKey: usageKey)
    }

    /// Updates daily favorites if a new day has started.
    @discardableResult
    public func updateIfNeeded(for date: Date) -> Bool {
        let start = Calendar.current.startOfDay(for: date)
        guard lastUpdate < start else { return false }
        dailyTopVoiceIDs = usage.sorted { $0.value > $1.value }
            .prefix(10)
            .map { $0.key }
        store.set(dailyTopVoiceIDs, forKey: topKey)
        usage.removeAll()
        store.set(usage, forKey: usageKey)
        lastUpdate = start
        store.set(lastUpdate, forKey: dateKey)
        return true
    }
}
