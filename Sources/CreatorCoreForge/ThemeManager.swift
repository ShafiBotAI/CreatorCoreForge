import Foundation
#if canImport(Combine)
import Combine

/// Manages theme preferences (light/dark/high contrast) and syncs them across devices.
public final class ThemeManager: ObservableObject {
    public enum Theme: String, Codable, CaseIterable {
        case light, dark, highContrast
    }

    public static let shared = ThemeManager()

    @Published public private(set) var current: Theme = .light

    private let userID: String
    private let sync: SyncService
    private let fileURL: URL

    public init(userID: String = "local",
                directory: URL? = nil,
                sync: SyncService = SettingsSync.shared) {
        self.userID = userID
        self.sync = sync
        let dir = directory ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = dir.appendingPathComponent("theme.json")
        if let data = try? Data(contentsOf: fileURL),
           let theme = try? JSONDecoder().decode(Theme.self, from: data) {
            self.current = theme
        }
    }

    /// Apply and upload a new theme preference.
    public func apply(_ theme: Theme) {
        current = theme
        persist()
        sync.upload(["theme": theme.rawValue], userID: userID) { _ in }
    }

    /// Fetch theme preferences from the remote service if available.
    public func load(completion: @escaping (Theme?) -> Void) {
        sync.fetch(userID: userID) { [weak self] result in
            guard let self = self else { return }
            if let remote = result as? [String: String],
               let value = remote["theme"],
               let theme = Theme(rawValue: value) {
                self.current = theme
                self.persist()
                completion(theme)
            } else {
                completion(nil)
            }
        }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(current) {
            try? data.write(to: fileURL)
        }
    }
}
#else

public final class ThemeManager {
    public enum Theme: String, Codable, CaseIterable {
        case light, dark, highContrast
    }

    public static let shared = ThemeManager()

    public private(set) var current: Theme = .light

    private let userID: String
    private let sync: SyncService
    private let fileURL: URL

    public init(userID: String = "local",
                directory: URL? = nil,
                sync: SyncService = SettingsSync.shared) {
        self.userID = userID
        self.sync = sync
        let dir = directory ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = dir.appendingPathComponent("theme.json")
        if let data = try? Data(contentsOf: fileURL),
           let theme = try? JSONDecoder().decode(Theme.self, from: data) {
            self.current = theme
        }
    }

    public func apply(_ theme: Theme) {
        current = theme
        persist()
        sync.upload(["theme": theme.rawValue], userID: userID) { _ in }
    }

    public func load(completion: @escaping (Theme?) -> Void) {
        sync.fetch(userID: userID) { [weak self] result in
            guard let self = self else { return }
            if let remote = result as? [String: String],
               let value = remote["theme"],
               let theme = Theme(rawValue: value) {
                self.current = theme
                self.persist()
                completion(theme)
            } else {
                completion(nil)
            }
        }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(current) {
            try? data.write(to: fileURL)
        }
    }
}
#endif

// Example usage:
// ThemeManager.shared.apply(.dark)
