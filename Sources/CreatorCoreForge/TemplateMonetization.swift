import Foundation

/// Simple helper for monetizing templates in CoreForge Studio.
public struct TemplateMonetization {
    public init() {}

    /// Returns a string indicating the template price for sale.
    public func monetize(template: String, price: Double) -> String {
        "\(template)-for-\(price)"
    }
}
