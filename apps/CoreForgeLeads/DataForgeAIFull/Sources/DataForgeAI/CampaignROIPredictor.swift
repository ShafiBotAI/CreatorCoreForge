import Foundation

/// Predicts return on investment for lead campaigns.
public struct CampaignROIPredictor {
    public init() {}

    public func roi(revenue: Double, cost: Double) -> Double {
        guard cost > 0 else { return 0 }
        return (revenue - cost) / cost * 100
    }
}
