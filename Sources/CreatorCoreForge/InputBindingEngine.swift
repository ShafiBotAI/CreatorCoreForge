import Foundation

/// Simple input binding state manager.
public final class InputBindingEngine {
    private var values: [String: String] = [:]
    public init() {}

    /// Bind a value to a field name.
    public func bind(field: String, value: String) {
        values[field] = value
    }

    /// Retrieve current value for a field.
    public func value(for field: String) -> String? {
        values[field]
    }

    /// Returns computed fields using a transform closure.
    public func computed(_ name: String, transform: ([String: String]) -> String) -> String {
        return transform(values)
    }
}
