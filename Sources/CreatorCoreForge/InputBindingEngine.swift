import Foundation

/// Simple input binding state manager.
public final class InputBindingEngine {
    private var values: [String: String] = [:]
    private var computedTransforms: [String: ([String: String]) -> String] = [:]
    private var watchers: [String: [(String) -> Void]] = [:]

    public init() {}

    /// Bind a value to a field name and update computed fields.
    public func bind(field: String, value: String) {
        values[field] = value
        evaluateComputed()
        triggerWatchers(for: field)
    }

    /// Bind a computed field that derives its value from other inputs.
    public func bindComputed(field: String, transform: @escaping ([String: String]) -> String) {
        computedTransforms[field] = transform
        values[field] = transform(values)
        triggerWatchers(for: field)
    }

    /// Evaluate all computed field transforms.
    public func evaluateComputed() {
        for (field, block) in computedTransforms {
            values[field] = block(values)
            triggerWatchers(for: field)
        }
    }

    /// Retrieve current value for a field.
    public func value(for field: String) -> String? {
        evaluateComputed()
        return values[field]
    }

    /// All current values, including computed fields.
    public var allValues: [String: String] {
        evaluateComputed()
        return values
    }

    /// Returns computed fields using a transform closure.
    public func computed(_ name: String, transform: ([String: String]) -> String) -> String {
        return transform(values)
    }

    /// Register a closure to run when a specific field value changes.
    public func addWatcher(for field: String, action: @escaping (String) -> Void) {
        watchers[field, default: []].append(action)
    }

    /// Trigger watchers for a particular field.
    private func triggerWatchers(for field: String) {
        let val = values[field] ?? ""
        for action in watchers[field] ?? [] {
            action(val)
        }
    }
}
