import Foundation

/// Handles basic currency formatting with locale awareness.
public struct GlobalCurrencySupport {
    private let formatter: NumberFormatter

    public init(locale: Locale = Locale.current) {
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
    }

    public func format(amount: Double) -> String {
        formatter.string(from: NSNumber(value: amount)) ?? "$\(amount)"
    }
}
