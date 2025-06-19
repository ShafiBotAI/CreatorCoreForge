import Foundation

/// Suggests beats from the marketplace based on lyrics sentiment and mood keywords.
public final class BeatSuggestionEngine {
    private let marketplace: BeatMarketplace

    public init(marketplace: BeatMarketplace) {
        self.marketplace = marketplace
    }

    public func suggestBeats(lyrics: String, mood: String, top: Int) -> [String] {
        let allBeats = marketplace.listBeats()
        let keywords = (lyrics + " " + mood).lowercased()
        let scored = allBeats.map { name -> (String, Int) in
            let score = keywords.contains(name.lowercased()) ? 1 : 0
            return (name, score)
        }
        return scored.sorted { $0.1 > $1.1 }.prefix(top).map { $0.0 }
    }
}
