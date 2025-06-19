import Foundation

/// Generates outreach emails tailored to a target persona and lead.
public final class EmailGenerator {
    private let service: OpenAIService

    public init(service: OpenAIService) {
        self.service = service
    }

    public func generateEmail(to lead: Lead, persona: Persona, completion: @escaping (String) -> Void) {
        let prompt = "Write a friendly email to \(lead.name) at \(lead.company) from the viewpoint of a salesperson targeting \(persona.description)."
        service.sendPrompt(prompt) { result in
            switch result {
            case .success(let text): completion(text)
            case .failure: completion("Unable to generate email")
            }
        }
    }
}
