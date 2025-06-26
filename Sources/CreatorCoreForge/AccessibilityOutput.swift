import Foundation

/// Outputs basic Braille or voice commands.
public final class AccessibilityOutput {
    public init() {}

    public func braille(for text: String) -> String {
        let map: [Character: Character] = [
            "a": "⠁", "b": "⠃", "c": "⠉", "d": "⠙", "e": "⠑",
            "f": "⠋", "g": "⠛", "h": "⠓", "i": "⠊", "j": "⠚",
            "k": "⠅", "l": "⠇", "m": "⠍", "n": "⠝", "o": "⠕",
            "p": "⠏", "q": "⠟", "r": "⠗", "s": "⠎", "t": "⠞",
            "u": "⠥", "v": "⠧", "w": "⠺", "x": "⠭", "y": "⠽",
            "z": "⠵"
        ]
        return String(text.map {
            let lower = Character(String($0).lowercased())
            return map[lower] ?? $0
        })
    }
}
