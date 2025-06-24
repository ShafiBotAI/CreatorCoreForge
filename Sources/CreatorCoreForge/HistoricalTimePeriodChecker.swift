import Foundation

/// Analyzes text for references that indicate a likely historical time period.
public struct HistoricalTimePeriodChecker {
    /// Simple keywords representing different eras.
    public struct TimePeriod: Hashable {
        public let name: String
        public let keywords: [String]
    }

    /// Default time periods used for detection.
    public static var defaultPeriods: [TimePeriod] = [
        TimePeriod(name: "Ancient", keywords: ["chariot", "oracle", "empire", "togas"]),
        TimePeriod(name: "Medieval", keywords: ["castle", "knight", "kingdom", "serf", "sword"]),
        TimePeriod(name: "Victorian", keywords: ["queen victoria", "steam", "corset", "industrial"]),
        TimePeriod(name: "Modern", keywords: ["internet", "smartphone", "globalization"])
    ]

    /// Returns the set of detected period names found in the text.
    public static func detectPeriods(in text: String) -> [String] {
        let lower = text.lowercased()
        var matches: [String] = []
        for period in defaultPeriods {
            if period.keywords.contains(where: { lower.contains($0) }) {
                matches.append(period.name)
            }
        }
        return matches
    }
}
