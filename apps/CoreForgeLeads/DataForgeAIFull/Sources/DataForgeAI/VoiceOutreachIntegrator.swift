import Foundation

/// Connects lead data with voice outreach assistant.
public final class VoiceOutreachIntegrator {
    private let assistant: VoiceOutreachAssistant

    public init(assistant: VoiceOutreachAssistant = VoiceOutreachAssistant()) {
        self.assistant = assistant
    }

    public func generateVoiceMessage(for lead: Lead, mood: String = "friendly") -> String {
        assistant.script(for: lead, mood: mood)
    }
}
