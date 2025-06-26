import Foundation

/// Converts text to a braille representation.
public final class BrailleOutputService {
    public init() {}

    public func translate(_ text: String) -> String {
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
