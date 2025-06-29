import Foundation

/// Simulates publishing performance for preview purposes.
public struct PublishingSimulator {
    public init() {}

    public func simulate(blurb: String, price: Double) -> String {
        let sales = Int(1000 / max(price, 0.1))
        let preview = String(blurb.prefix(30))
        return "\(preview)... Potential sales: \(sales)"
    }
}
