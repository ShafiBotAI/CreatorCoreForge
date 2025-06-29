import Foundation

/// Simple tone adaptation tool for rewriting text in a target style.
public struct ToneAdapter {
    public enum Style {
        case noir, epic, whimsical
    }

    public init() {}

    /// Rewrite text by inserting a style marker.
    public func rewrite(_ text: String, style: Style) -> String {
        switch style {
        case .noir:
            return "[Noir] " + text
        case .epic:
            return "[Epic] " + text
        case .whimsical:
            return "[Whimsical] " + text
        }
    }
}
