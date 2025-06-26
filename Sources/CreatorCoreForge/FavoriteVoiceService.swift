import Foundation
#if canImport(Combine)
import Combine
#else
public protocol ObservableObject {}
@propertyWrapper public struct Published<Value> {
    public var wrappedValue: Value
    public init(wrappedValue: Value) { self.wrappedValue = wrappedValue }
}
#endif

/// Stores user-selected favorite voices for quick access.
public final class FavoriteVoiceService: ObservableObject {
    public static let shared = FavoriteVoiceService()
    @Published public private(set) var favorites: Set<String>
    private let key = "VV_FavoriteVoices"
    private let store: UserDefaults
    
    public init(store: UserDefaults = .standard) {
        self.store = store
        if let arr = store.array(forKey: key) as? [String] {
            favorites = Set(arr)
        } else {
            favorites = []
        }
    }

    /// Toggle a voice as favorite or remove it if already set.
    public func toggle(voiceID: String) {
        if favorites.contains(voiceID) {
            favorites.remove(voiceID)
        } else {
            favorites.insert(voiceID)
        }
        persist()
    }

    /// Check whether a voice ID is marked as favorite.
    public func isFavorite(_ voiceID: String) -> Bool {
        favorites.contains(voiceID)
    }

    private func persist() {
        store.set(Array(favorites), forKey: key)
    }
}
