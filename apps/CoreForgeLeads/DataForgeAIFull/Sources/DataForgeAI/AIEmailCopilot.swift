import Foundation

/// Outbound messaging assistant that orchestrates outreach emails.
public final class AIEmailCopilot {
    private let service: OpenAIService

    public init(service: OpenAIService) {
        self.service = service
    }

    /// Compose the initial outreach email to a lead.
    public func composeIntroEmail(to lead: Lead,
                                  persona: Persona,
                                  completion: @escaping (String) -> Void) {
        let prompt = "Write a short sales email to \(lead.name) at \(lead.company) from the viewpoint of \(persona.description)."
        service.sendPrompt(prompt) { result in
            completion((try? result.get()) ?? "Unable to generate email")
        }
    }

    /// Generate a sequence of follow-up emails.
    public func composeFollowUps(to lead: Lead,
                                 persona: Persona,
                                 count: Int,
                                 completion: @escaping ([String]) -> Void) {
        guard count > 0 else { completion([]); return }
        var results: [String] = []
        func next(_ index: Int) {
            guard index < count else { completion(results); return }
            let prompt = "Write follow up email #\(index + 1) to \(lead.name) at \(lead.company) from the viewpoint of \(persona.description)."
            service.sendPrompt(prompt) { result in
                results.append((try? result.get()) ?? "Unable to generate email")
                next(index + 1)
            }
        }
        next(0)
    }
}
