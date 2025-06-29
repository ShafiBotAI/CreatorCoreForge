import Foundation

/// Generates a simple voice message outreach script.
public struct VoiceOutreachAssistant {
    public init() {}

    public func script(for lead: Lead, mood: String) -> String {
        "Hello \(lead.name), I'm reaching out with a \(mood) offer from \(lead.company)."
    }
}
