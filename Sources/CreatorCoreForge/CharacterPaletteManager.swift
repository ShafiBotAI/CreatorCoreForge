import Foundation

/// Manages color palettes associated with characters for visual scenes.
public final class CharacterPaletteManager {
    private var palettes: [String: [String]] = [:]

    public init() {}

    /// Assign a color palette to a character name.
    public func setPalette(for character: String, palette: [String]) {
        palettes[character.lowercased()] = palette
    }

    /// Retrieve the palette for the given character.
    public func palette(for character: String) -> [String]? {
        palettes[character.lowercased()]
    }
}
