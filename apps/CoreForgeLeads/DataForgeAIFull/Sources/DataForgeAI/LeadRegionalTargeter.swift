import Foundation

/// Provides simple utilities for multilingual and regional targeting.
public struct LeadRegionalTargeter {
    public init() {}

    /// Filter leads by region code or substring match.
    public func filter(leads: [Lead], region: String) -> [Lead] {
        let key = region.lowercased()
        return leads.filter { $0.region.lowercased().contains(key) }
    }

    /// Group leads by region.
    public func groupByRegion(_ leads: [Lead]) -> [String: [Lead]] {
        Dictionary(grouping: leads, by: { $0.region })
    }

    /// Localize a short greeting for the provided language code.
    public func localizedGreeting(language: String) -> String {
        switch language.lowercased() {
        case "es":
            return "Hola"
        case "fr":
            return "Bonjour"
        case "de":
            return "Hallo"
        default:
            return "Hello"
        }
    }
}
