import Foundation

/// Composition rules for character layout.
public enum CompositionRule {
    case ruleOfThirds
    case motionFocus
}

/// Generates frame labels based on composition rules.
public struct CinematicComposer {
    public init() {}

    public func compose(characters: [String], rule: CompositionRule) -> [String] {
        switch rule {
        case .ruleOfThirds:
            return characters.enumerated().map { "\($1)-thirds-\($0)" }
        case .motionFocus:
            return characters.map { "\($0)-motion" }
        }
    }
}
