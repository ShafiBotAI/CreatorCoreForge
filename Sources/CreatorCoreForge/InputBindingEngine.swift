import Foundation

/// Simple input binding state manager.
public final class InputBindingEngine {
    private var values: [String: String] = [:]
    private var computedTransforms: [String: ([String: String]) -> String] = [:]
    public init() {}

    /// Bind a value to a field name and update computed fields.
    public func bind(field: String, value: String) {
        values[field] = value
        evaluateComputed()
    }

    /// Bind a computed field that derives its value from other inputs.
    public func bindComputed(field: String, transform: @escaping ([String: String]) -> String) {
        computedTransforms[field] = transform
        values[field] = transform(values)
    }

    /// Evaluate all computed field transforms.
    public func evaluateComputed() {
        for (field, block) in computedTransforms {
            values[field] = block(values)
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
}
