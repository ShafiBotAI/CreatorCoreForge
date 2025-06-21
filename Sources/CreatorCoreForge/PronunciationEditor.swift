import Foundation

/// Basic pronunciation editor using placeholder phoneme mapping.
public final class PronunciationEditor {
    public init() {}

    public func phonemes(for word: String) -> [String] {
        word.map { String($0) }
    }
}
