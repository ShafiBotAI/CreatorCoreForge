import Foundation

/// Manages audio tracks per character for multitrack mastering.
public final class CharacterTrackManager {
    private var tracks: [String: [Data]] = [:]
    public init() {}

    /// Append an audio segment for a character.
    public func append(_ data: Data, for character: String) {
        tracks[character, default: []].append(data)
    }

    /// Retrieve all segments for a given character.
    public func track(for character: String) -> [Data] {
        tracks[character] ?? []
    }

    /// Return all character names with recorded tracks.
    public var allCharacters: [String] {
        Array(tracks.keys)
    }
}
