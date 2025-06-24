import Foundation

/// Represents a collection of NSFW sound effects such as moans or ASMR breaths.
public struct NSFWSFXPack: Codable, Equatable {
    public let name: String
    public let files: [String]
    public init(name: String, files: [String]) {
        self.name = name
        self.files = files
    }
}

/// Manages available NSFW sound effect packs for playback.
public final class NSFWSFXPackManager {
    public static let shared = NSFWSFXPackManager()
    private var packs: [NSFWSFXPack] = []

    private init() {}

    /// Register a new SFX pack.
    public func register(_ pack: NSFWSFXPack) {
        if !packs.contains(pack) {
            packs.append(pack)
        }
    }

    /// List all registered packs.
    public func listPacks() -> [NSFWSFXPack] {
        packs
    }

    /// Get file names for a pack by name.
    public func files(for name: String) -> [String] {
        packs.first { $0.name == name }?.files ?? []
    }
}

