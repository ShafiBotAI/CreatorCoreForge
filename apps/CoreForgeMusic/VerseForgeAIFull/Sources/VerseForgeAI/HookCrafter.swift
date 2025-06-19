import Foundation

public struct HookCrafter {
    public init() {}

    /// Generate candidate hooks from a lyric snippet
    public func generateHooks(from lyrics: String) -> [String] {
        let lines = lyrics.split(separator: "\n")
        return lines.map { "\($0)" }.filter { !$0.isEmpty }
    }

    /// Split-test hooks and rank by mock virality score
    public func rankHooks(_ hooks: [String]) -> [(hook: String, score: Int)] {
        hooks.map { ($0, Int.random(in: 50...100)) }
            .sorted { $0.score > $1.score }
    }
}
