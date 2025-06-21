import Foundation

/// Generates placeholder transitions between chapters.
public struct DynamicChapterTransitions {
    public init() {}

    public func transition(from: Int, to: Int) -> String {
        "Transition from \(from) to \(to)"
    }
}
