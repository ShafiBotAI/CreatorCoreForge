import Foundation

public struct ChallengeGenerator {
    public func generate(from seed: String) -> [String] {
        seed.split(separator: " ").map { String($0) }
    }
}

public struct LeaderboardEvents {
    public func rank(scores: [Int]) -> [Int] {
        scores.sorted(by: >)
    }
}

public struct MarketplaceItems {
    public func trade(item: String, for coins: Int) -> String {
        "\(item)-for-\(coins)"
    }
}
