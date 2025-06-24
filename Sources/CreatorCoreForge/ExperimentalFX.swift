import Foundation

/// Container for experimental audio effects.
public final class ExperimentalFX {
    public init() {}
    public func apply(_ name: String, to input: String) -> String {
        return "[\(name)]" + input
    }
}
