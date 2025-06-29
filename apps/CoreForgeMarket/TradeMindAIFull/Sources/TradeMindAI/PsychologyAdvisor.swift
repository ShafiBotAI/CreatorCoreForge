import Foundation

/// Tracks user emotions and provides simple advice.
public final class PsychologyAdvisor {
    private var log: [String: Int] = [:]
    public init() {}

    public func track(emotion: String) {
        log[emotion, default: 0] += 1
    }

    public func summary() -> String {
        log.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
    }
}
