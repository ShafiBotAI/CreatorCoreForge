import Foundation

/// Compresses large lore passages into short summaries.
final class LoreCompressionTool {
    private let service: OpenAIService?

    init(service: OpenAIService? = nil) {
        self.service = service
    }

    /// Compress the provided lore text into the desired number of sentences.
    /// Falls back to naive trimming if no OpenAI service is available or on error.
    func compress(lore text: String, sentences: Int = 3, completion: @escaping (String) -> Void) {
        guard let service = service else {
            let summary = text.components(separatedBy: ".").prefix(sentences).joined(separator: ".")
            completion(summary + (summary.isEmpty ? "" : "."))
            return
        }

        let prompt = "Summarize the following lore into \(sentences) sentences:\n" + text
        service.sendPrompt(prompt) { result in
            switch result {
            case .success(let summary):
                completion(summary.trimmingCharacters(in: .whitespacesAndNewlines))
            case .failure:
                let summary = text.components(separatedBy: ".").prefix(sentences).joined(separator: ".")
                completion(summary + (summary.isEmpty ? "" : "."))
            }
        }
    }
}
