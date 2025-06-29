import Foundation

public struct VisualScene {
    public let description: String
    public let referenceArt: String
}

/// Composes visual scene descriptions with placeholder reference art.
public struct VisualSceneComposer {
    public init() {}

    public func compose(from text: String) -> VisualScene {
        let art = "AI Art: " + text.prefix(20)
        return VisualScene(description: text, referenceArt: String(art))
    }
}
