import Foundation

/// Outbound messaging assistant that orchestrates outreach emails.
public final class AIEmailCopilot {
    private let service: OpenAIService

    public init(service: OpenAIService) {
        self.service = service
    }

    /// Compose the initial outreach email to a lead.
    /// - Parameters:
    ///   - lead: Lead to contact.
    ///   - persona: Desired persona style.
    ///   - tone: Desired tone (friendly, professional, etc.).
    ///   - product: Product name to mention.
    ///   - industry: Optional industry override.
    public func composeIntroEmail(to lead: Lead,
                                  persona: Persona,
                                  tone: String = "professional",
                                  product: String = "our product",
                                  industry: String? = nil,
                                  completion: @escaping (String) -> Void) {
        let ind = industry ?? lead.industry
        var prompt = "Write a \(tone) sales email promoting \(product) to \(lead.name) at \(lead.company). "
        prompt += "The company operates in the \(ind) industry. "
        prompt += "Write from the viewpoint of \(persona.description)."
        service.sendPrompt(prompt) { result in
            completion((try? result.get()) ?? "Unable to generate email")
        }
    }

    /// Generate a sequence of follow-up emails.
    public func composeFollowUps(to lead: Lead,
                                 persona: Persona,
                                 count: Int,
                                 tone: String = "professional",
                                 product: String = "our product",
                                 industry: String? = nil,
                                 completion: @escaping ([String]) -> Void) {
        guard count > 0 else { completion([]); return }
        var results: [String] = []
        func next(_ index: Int) {
            guard index < count else { completion(results); return }
            let ind = industry ?? lead.industry
            var prompt = "Write a \(tone) follow up email #\(index + 1) to \(lead.name) at \(lead.company). "
            prompt += "Promote \(product) for the \(ind) industry from the viewpoint of \(persona.description)."
            service.sendPrompt(prompt) { result in
                results.append((try? result.get()) ?? "Unable to generate email")
                next(index + 1)
            }
        }
        next(0)
    }
}
