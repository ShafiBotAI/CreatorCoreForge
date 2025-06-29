import Foundation

/// Generates LinkedIn messages with tone optimization.
public struct LinkedInMessageAssistant {
    public init() {}

    public func craftMessage(to lead: Lead, tone: String) -> String {
        "Hi \(lead.name), let's connect!" + (tone.lowercased() == "casual" ? " :)" : ".")
    }
}
