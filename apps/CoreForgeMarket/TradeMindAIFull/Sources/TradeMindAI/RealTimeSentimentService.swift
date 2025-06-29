import Foundation

/// Aggregates sentiment across multiple news sources.
public final class RealTimeSentimentService {
    private let fetcher: (URL) -> String?
    private let detector: SentimentDetector

    public init(detector: SentimentDetector = SentimentDetector(),
                fetcher: @escaping (URL) -> String? = { _ in nil }) {
        self.detector = detector
        self.fetcher = fetcher
    }

    /// Returns the average sentiment score for a search query combining
    /// Twitter, Reddit and financial news results.
    public func combinedSentiment(for query: String, completion: @escaping (Double) -> Void) {
        let urls = [
            URL(string: "https://twitter.com/search?q=\(query)"),
            URL(string: "https://reddit.com/search?q=\(query)"),
            URL(string: "https://news.google.com/search?q=\(query)")
        ].compactMap { $0 }
        let texts = urls.compactMap(fetcher)
        guard !texts.isEmpty else { completion(0); return }
        let score = texts.map { detector.sentimentScore(for: $0) }
            .reduce(0, +) / Double(texts.count)
        completion(score)
    }
}
