import Foundation

/// Central registry of short sound effects used across apps.
public struct SoundEffectsDatabase {
    /// Individual record for a sound effect clip.
    public struct Record: Hashable, Codable {
        public let name: String
        public let category: String
        public let isNSFW: Bool
        public init(name: String, category: String, isNSFW: Bool = false) {
            self.name = name
            self.category = category
            self.isNSFW = isNSFW
        }
    }

    /// Shared instance loaded with built-in records.
    public static var shared = SoundEffectsDatabase()

    private(set) var records: [Record] = []

    private init() {
        loadDefaults()
    }

    mutating private func loadDefaults() {
        records.append(contentsOf: [
            Record(name: "ui_click", category: "Interface"),
            Record(name: "swipe", category: "Interface"),
            Record(name: "error_beep", category: "Interface"),
            Record(name: "sword_swing", category: "Combat"),
            Record(name: "sword_clash", category: "Combat"),
            Record(name: "explosion_big", category: "Combat"),
            Record(name: "forest_day", category: "Nature"),
            Record(name: "water_stream", category: "Nature"),
            Record(name: "fire_crackle", category: "Nature"),
            Record(name: "sci_whoosh", category: "SciFi"),
            Record(name: "laser_blast", category: "SciFi"),
            Record(name: "spaceship_idle", category: "SciFi"),
            Record(name: "moan_soft1", category: "NSFW", isNSFW: true),
            Record(name: "breath1", category: "NSFW", isNSFW: true)
        ])
    }

    /// Lookup records optionally filtered by category and NSFW flag.
    public func list(category: String? = nil, includeNSFW: Bool = false) -> [Record] {
        records.filter { (category == nil || $0.category == category!) && (includeNSFW || !$0.isNSFW) }
    }
}
