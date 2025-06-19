import Foundation

/// Simple manager for enabling AI Studio features across apps.
public final class AIStudioMode {
    public private(set) var isActive: Bool = false
    public init() {}

    /// Toggle the studio mode state.
    public func toggle() { isActive.toggle() }

    /// Applies a studio prefix to a prompt when active.
    public func apply(to prompt: String) -> String {
        guard isActive else { return prompt }
        return "[Studio] " + prompt
    }
}
