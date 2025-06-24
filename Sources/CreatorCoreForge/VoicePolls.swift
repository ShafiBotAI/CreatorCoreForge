import Foundation

/// Simple poll manager for voice and tone selection.
public final class VoicePolls {
    private var votes: [String: Int] = [:]
    public init() {}

    public func vote(for option: String) {
        votes[option, default: 0] += 1
    }

    public func topChoice() -> String? {
        votes.max { $0.value < $1.value }?.key
    }
}
