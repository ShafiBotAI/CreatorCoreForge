#if canImport(SwiftUI)
import SwiftUI
import Foundation

/// AI chat Q&A about selected content.
struct AskBookAIView: View {
    @State private var question = ""
    @State private var responses: [String] = []
    @State private var isSending = false

    private let openAI: OpenAIService?

    init() {
        if let key = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] {
            openAI = OpenAIService(apiKey: key)
        } else {
            openAI = nil
        }
    }

    var body: some View {
        VStack {
            List(responses, id: \.self) {
                Text($0)
                    .padding(.vertical, 4)
            }
            HStack {
                TextField("Ask a question", text: $question)
                    .textFieldStyle(.roundedBorder)
                if isSending {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                Button("Send") { sendQuestion() }
                    .disabled(question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSending)
            }
            .padding()
        }
        .navigationTitle("Ask Book AI")
    }

    private func sendQuestion() {
        let prompt = question.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !prompt.isEmpty else { return }
        responses.append("Q: " + prompt)
        question = ""
        guard let openAI else {
            responses.append("Error: API key not set")
            return
        }
        isSending = true
        openAI.sendPrompt(prompt) { result in
            DispatchQueue.main.async {
                isSending = false
                switch result {
                case .success(let answer):
                    responses.append("A: " + answer.trimmingCharacters(in: .whitespacesAndNewlines))
                case .failure(let error):
                    responses.append("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    NavigationView { AskBookAIView() }
}
#endif
