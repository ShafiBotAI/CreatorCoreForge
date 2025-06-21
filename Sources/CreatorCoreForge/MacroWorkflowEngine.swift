import Foundation

/// Records and replays simple UI action macros.
public final class MacroWorkflowEngine {
    private var actions: [String] = []

    public init() {}

    /// Returns the number of recorded actions.
    public var count: Int { actions.count }

    /// Records a UI action for later playback.
    public func record(_ action: String) {
        actions.append(action)
    }

    /// Removes the most recently recorded action and returns it.
    @discardableResult
    public func undo() -> String? {
        actions.popLast()
    }

    /// Clears all recorded actions.
    public func clear() {
        actions.removeAll()
    }

    /// Returns the list of recorded actions in order.
    public func replay() -> [String] {
        actions
    }
}
