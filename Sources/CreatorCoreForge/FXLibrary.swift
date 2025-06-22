import Foundation

/// Stores sound effect names grouped by genre/category.
public struct FXLibrary {
    public enum Category: String, CaseIterable, Codable {
        case forest, city, tavern, spaceship, generic
    }

    private var effects: [Category: [String]] = [
        .forest: ["wind_gust", "birds", "leaves_rustle"],
        .city: ["traffic", "crowd_chatter"],
        .tavern: ["mug_clink", "lute_loop"],
        .spaceship: ["engine_hum", "door_swish"],
        .generic: []
    ]

    public init() {}

    /// Return FX names for a given category.
    public func fx(for category: Category) -> [String] {
        effects[category] ?? []
    }

    /// Add a new effect to a category.
    public mutating func addFX(_ name: String, to category: Category) {
        effects[category, default: []].append(name)
    }

    /// Import a user FX pack with tagging support.
    public mutating func addPack(_ names: [String], category: Category) {
        effects[category, default: []].append(contentsOf: names)
    }
}
