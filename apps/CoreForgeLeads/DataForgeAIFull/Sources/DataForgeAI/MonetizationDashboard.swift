import Foundation

/// Tracks sales and revenue for creator lead packs.
public struct MonetizationDashboard {
    private(set) public var leadPacksSold: Int = 0
    private(set) public var revenue: Double = 0

    public init() {}

    public mutating func recordSale(packs: Int, pricePerPack: Double) {
        leadPacksSold += packs
        revenue += Double(packs) * pricePerPack
    }

    public func averageRevenuePerPack() -> Double {
        guard leadPacksSold > 0 else { return 0 }
        return revenue / Double(leadPacksSold)
    }
}
