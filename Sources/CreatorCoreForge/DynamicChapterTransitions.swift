import Foundation

/// Creates basic text descriptions for transitioning between chapters.
/// The engine selects a transition style and formats a short sentence
/// describing how to move from one chapter to the next.
public struct DynamicChapterTransitions {
    public init() {}

    private let styles = [
        "Fade", "Swipe", "Slide", "Cut", "Dissolve"
    ]

    /// Return a formatted transition description.
    /// - Parameters:
    ///   - from: The chapter index we are leaving.
    ///   - to: The chapter index we are entering.
    public func transition(from: Int, to: Int) -> String {
        let style = styles.randomElement() ?? "Cut"
        return "\(style) from chapter \(from) to \(to)"
    }
}
