import Foundation

/// Minimal representation of a lead used for testing.
public struct Lead {
    public var name: String
    public var email: String
    public var company: String
    public var industry: String
    public var region: String
    public init(name: String, email: String, company: String, industry: String, region: String) {
        self.name = name
        self.email = email
        self.company = company
        self.industry = industry
        self.region = region
    }
}

public final class CreditLedger {
    private(set) var credits: Int = 0
    public init() {}
    public func add(_ amount: Int) { credits += amount }
    public func bill(_ amount: Int) -> Bool {
        guard credits >= amount else { return false }
        credits -= amount
        return true
    }
}

public struct GlobalExchange {
    public func trade(id: String, for credit: Int) -> String {
        "Traded \(id) for \(credit)"
    }
}

public struct ScoringEngine {
    public func score(leads: [Int]) -> Double {
        guard !leads.isEmpty else { return 0 }
        let total = leads.reduce(0, +)
        return Double(total) / Double(leads.count)
    }
}

// MARK: - Phase 8 Leads Features 21-30

/// Tracks revenue from reselling lead packs.
public final class CreatorMonetizationDashboard {
    private var sales: Int = 0
    public init() {}
    public func recordSale(packs: Int) { sales += packs }
    public var totalSales: Int { sales }
}

/// Manages a list of affiliate resellers.
public struct AffiliateMarketplace {
    private var resellers: [String] = []
    public init() {}
    public mutating func register(reseller: String) { resellers.append(reseller) }
    public var allResellers: [String] { resellers }
}

/// Simple gamified opt-in helper.
public struct GamifiedLeadGen {
    public init() {}
    public func spinWheel(options: [String]) -> String? { options.randomElement() }
}

/// Calculates average open rate for campaigns.
public struct EmailHeatmapAnalyzer {
    public init() {}
    public func averageOpenRate(_ rates: [Double]) -> Double {
        guard !rates.isEmpty else { return 0 }
        return rates.reduce(0, +) / Double(rates.count)
    }
}

/// Predicts ROI from spend and revenue.
public struct CampaignROIPredictor {
    public init() {}
    public func predictROI(spend: Double, revenue: Double) -> Double {
        guard spend > 0 else { return 0 }
        return (revenue - spend) / spend
    }
}

/// Naive SEO signal detection from HTML snippets.
public struct SEOSignalDetector {
    public init() {}
    public func detect(from html: String) -> [String] {
        var signals: [String] = []
        if html.contains("<title>") { signals.append("title") }
        if html.contains("meta") { signals.append("meta") }
        return signals
    }
}

/// Builds a simple profile map of industries across leads.
public struct LeadDNAProfileBuilder {
    public init() {}
    public func build(from leads: [Lead]) -> [String: Int] {
        var profile: [String: Int] = [:]
        for lead in leads { profile[lead.industry, default: 0] += 1 }
        return profile
    }
}

/// Generates a message tagged with the voice to use.
public struct VoiceOutreachIntegration {
    public init() {}
    public func combine(text: String, with voice: String) -> String {
        "\(voice): \(text)"
    }
}

/// Classifies basic lead forms by intent keywords.
public struct LeadFormClassifier {
    public init() {}
    public func classify(fields: [String: String]) -> String {
        if fields["interest"]?.lowercased().contains("buy") == true {
            return "hot"
        }
        return "cold"
    }
}

/// Prioritizes leads where the email is marked urgent.
public struct LeadPrioritizer {
    public init() {}
    public func prioritize(leads: [Lead], urgentEmails: Set<String>) -> [Lead] {
        leads.sorted { urgentEmails.contains($0.email) && !urgentEmails.contains($1.email) }
    }
}
