import Foundation

public final class MarketMoodIndex {
    private let sentimentService: RealTimeSentimentService

    public init(sentimentService: RealTimeSentimentService = RealTimeSentimentService()) {
        self.sentimentService = sentimentService
    }

    public func moodScore(for query: String, macroIndex: Double, completion: @escaping (Double) -> Void) {
        sentimentService.combinedSentiment(for: query) { sentiment in
            let score = (sentiment + macroIndex) / 2
            completion(score)
        }
    }
}
