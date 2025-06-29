import Foundation

/// Manages affiliate resellers and their earned commissions.
public final class AffiliateMarketplace {
    public struct Affiliate {
        public let id: String
        public var sales: Int
        public var commissionRate: Double

        public init(id: String, commissionRate: Double) {
            self.id = id
            self.sales = 0
            self.commissionRate = commissionRate
        }
    }

    private var affiliates: [String: Affiliate] = [:]

    public init() {}

    public func registerAffiliate(id: String, commissionRate: Double) {
        affiliates[id] = Affiliate(id: id, commissionRate: commissionRate)
    }

    public func recordSale(affiliateId: String) {
        affiliates[affiliateId]?.sales += 1
    }

    public func payout(for affiliateId: String, pricePerSale: Double) -> Double {
        guard let affiliate = affiliates[affiliateId] else { return 0 }
        let payout = Double(affiliate.sales) * pricePerSale * affiliate.commissionRate
        affiliates[affiliateId]?.sales = 0
        return payout
    }
}
