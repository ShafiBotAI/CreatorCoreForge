import Foundation

/// Records and replays simple UI action macros.
public final class MacroWorkflowEngine {
    private var actions: [String] = []
    public init() {}

    public func record(_ action: String) {
        actions.append(action)
    }

    public func replay() -> [String] {
        actions
    }
}
