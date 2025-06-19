import Foundation

/// Naive engine that predicts possible next plot points using a markov-like model.
final class PlotPredictionEngine {
    private let service: OpenAIService

    init(service: OpenAIService) {
        self.service = service
    }

    func predictNextPlot(from synopsis: String, completion: @escaping (String) -> Void) {
        let prompt = "Given the following synopsis, predict plausible next events in one paragraph:\n" + synopsis
        service.sendPrompt(prompt) { result in
            switch result {
            case .success(let text):
                completion(text.trimmingCharacters(in: .whitespacesAndNewlines))
            case .failure:
                completion("Unable to predict plot at this time.")
            }
        }
    }
}
