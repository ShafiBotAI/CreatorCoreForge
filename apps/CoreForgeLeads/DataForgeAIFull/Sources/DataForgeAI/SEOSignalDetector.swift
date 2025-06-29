import Foundation

/// Detects SEO signals from a website's text content.
public struct SEOSignalDetector {
    public init() {}

    public func topKeywords(in text: String, count: Int = 3) -> [String] {
        let words = text.lowercased().split{ !$0.isLetter }
        var freq: [String: Int] = [:]
        for word in words {
            freq[String(word), default: 0] += 1
        }
        let sorted = freq.sorted { $0.value > $1.value }
        return Array(sorted.prefix(count).map { $0.key })
    }
}
