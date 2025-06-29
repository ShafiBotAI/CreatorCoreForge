import Foundation

public struct Lead: Codable {
    public var name: String
    public var email: String
    public var company: String
    public var industry: String
    public var region: String
    public var firmographics: [String: String] = [:]

    public init(name: String, email: String, company: String, industry: String, region: String) {
        self.name = name
        self.email = email
        self.company = company
        self.industry = industry
        self.region = region
    }
}

public final class LeadMiner {
    public init() {}

    /// Analyze the distribution of industries for the given leads
    public func analyzeTargetMarket(_ leads: [Lead]) -> [String: Int] {
        var tally: [String: Int] = [:]
        for lead in leads {
            tally[lead.industry, default: 0] += 1
        }
        return tally
    }

    /// Append basic firmographic details to a lead using Clearbit's autocomplete API.
    public func enrichLead(_ lead: Lead) -> Lead {
        let semaphore = DispatchSemaphore(value: 0)
        var result = lead
        enrichLead(lead) { enriched in
            result = enriched
            semaphore.signal()
        }
        semaphore.wait()
        return result
    }

    public func enrichLead(_ lead: Lead, completion: @escaping (Lead) -> Void) {
        guard let encoded = lead.company.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://autocomplete.clearbit.com/v1/companies/suggest?query=\(encoded)") else {
            completion(lead)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            var enriched = lead
            if let data = data,
               let arr = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]],
               let first = arr.first {
                if let name = first["name"] as? String {
                    enriched.firmographics["name"] = name
                }
                if let domain = first["domain"] as? String {
                    enriched.firmographics["domain"] = domain
                }
                if let logo = first["logo"] as? String {
                    enriched.firmographics["logo"] = logo
                }
            }
            completion(enriched)
        }.resume()
    }

    /// Asynchronously enrich a lead using async/await.
    @available(macOS 12, iOS 15, *)
    public func enrichLead(_ lead: Lead) async -> Lead {
        await withCheckedContinuation { continuation in
            enrichLead(lead) { enriched in
                continuation.resume(returning: enriched)
            }
        }
    }

    /// Insert lead details into an outreach template
    public func autoPersonalizeScript(for lead: Lead, template: String) -> String {
        template
            .replacingOccurrences(of: "{name}", with: lead.name)
            .replacingOccurrences(of: "{company}", with: lead.company)
    }

    /// Summarize firmographic trends for the set of leads
    public func analyzeFirmographicTrends(_ leads: [Lead]) -> [String: Int] {
        var counts: [String: Int] = [:]
        for lead in leads {
            for (key, value) in lead.firmographics {
                let k = "\(key):\(value)"
                counts[k, default: 0] += 1
            }
        }
        return counts
    }
}
