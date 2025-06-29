import Foundation

/// Finds the best mentor by comparing portfolio styles.
public struct MentorMatcher {
    public init() {}

    /// Returns the index of the closest mentor style.
    public func match(style: [Double], mentors: [[Double]]) -> Int? {
        guard !mentors.isEmpty else { return nil }
        func distance(_ a: [Double], _ b: [Double]) -> Double {
            zip(a, b).map { pow($0 - $1, 2) }.reduce(0, +)
        }
        let scores = mentors.map { distance(style, $0) }
        return scores.enumerated().min(by: { $0.element < $1.element })?.offset
    }
}
