import Foundation

/// Basic marketplace storing leads for sale and purchase.
public struct LeadListing {
    public var lead: Lead
    public var price: Double
}

public final class LeadMarketplace {
    private var listings: [String: [LeadListing]] = [:] // category -> listings
    private var verifiedLeads: Set<String> = []

    public init() {}

    public func list(_ lead: Lead, category: String, price: Double = 0) {
        let listing = LeadListing(lead: lead, price: price)
        listings[category, default: []].append(listing)
    }

    public func listings(in category: String) -> [LeadListing] {
        listings[category] ?? []
    }

    public func purchaseLead(from category: String) -> LeadListing? {
        guard var arr = listings[category], !arr.isEmpty else { return nil }
        let listing = arr.removeFirst()
        listings[category] = arr
        return listing
    }

    /// Mark a lead as verified in the marketplace.
    public func verify(leadEmail: String) {
        verifiedLeads.insert(leadEmail.lowercased())
    }

    /// Check if a lead is verified.
    public func isVerified(email: String) -> Bool {
        verifiedLeads.contains(email.lowercased())
    }
}
