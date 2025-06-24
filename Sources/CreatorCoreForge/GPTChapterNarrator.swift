import Foundation

/// Uses GPT for chapter segmentation and narration.
public final class GPTChapterNarrator {
    private let openAI: OpenAIService
    private let voiceAI: LocalVoiceAI

    public init(openAI: OpenAIService = OpenAIService(environmentKey: "OPENAI_API_KEY"),
                voiceAI: LocalVoiceAI = LocalVoiceAI()) {
        self.openAI = openAI
        self.voiceAI = voiceAI
    }

    /// Segment text into chapters using GPT.
    public func segment(text: String, completion: @escaping ([String]) -> Void) {
        let prompt = "Segment the following text into chapters:\n" + text
        openAI.sendPrompt(prompt) { result in
            switch result {
            case .success(let output):
                let chapters = output.components(separatedBy: "\n").filter { !$0.isEmpty }
                completion(chapters)
            case .failure:
                completion([text])
            }
        }
    }

    /// Narrate a chapter using synthesized voice.
    public func narrate(chapter: String, profile: VoiceProfile, completion: @escaping (Result<Data, Error>) -> Void) {
        voiceAI.synthesize(text: chapter, with: profile, completion: completion)
    }
}
