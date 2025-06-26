import Foundation

/// Rough language detection based on Unicode ranges.
public struct LanguageDetector {
    public init() {}

    public func detectLanguages(in text: String) -> [SupportedLanguage] {
        var counts: [SupportedLanguage: Int] = [:]
        for char in text {
            let scalar = char.unicodeScalars.first?.value ?? 0
            switch scalar {
            case 0x0400...0x04FF:
                counts[.russian, default: 0] += 1
            case 0x3040...0x309F:
                counts[.japanese, default: 0] += 1
            case 0x4E00...0x9FAF:
                counts[.chinese, default: 0] += 1
            default:
                counts[.english, default: 0] += 1
            }
        }
        return counts.sorted { $0.value > $1.value }.map { $0.key }
    }
}
