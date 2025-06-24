import Foundation

/// Simple rendering style enum for visual scenes.
public enum VisualStyle: Equatable {
    case anime, liveAction, fantasy
    case custom(String)
}

/// Applies visual styles to frame identifiers.
public final class StyleEngine {
    public init() {}

    public func apply(style: VisualStyle, to frame: String) -> String {
        switch style {
        case .anime: return "\(frame)-anime"
        case .liveAction: return "\(frame)-live"
        case .fantasy: return "\(frame)-fantasy"
        case .custom(let name): return "\(frame)-\(name)"
        }
    }
}
