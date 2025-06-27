#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Generates a short multiple choice quiz for the given book using OpenAI.
struct QuizGeneratorView: View {
    var book: Book
    @State private var questions: [String] = []
    @State private var isLoading = false
    @State private var error: String?
    private let service = OpenAIService(environmentKey: "OPENAI_API_KEY")

    var body: some View {
        List {
            if isLoading {
                ProgressView()
            } else if let error = error {
                Text(error).foregroundColor(.red)
            } else {
                ForEach(questions, id: \.self) { Text($0) }
            }
        }
        .navigationTitle("Quiz Generator")
        .toolbar { Button("Generate") { generateQuiz() } }
        .onAppear { if questions.isEmpty { generateQuiz() } }
    }

    private func generateQuiz() {
        isLoading = true
        error = nil
        let text = book.chapters.map { $0.text }.joined(separator: " ")
        let prompt = "Create a 3 question multiple choice quiz about the following text. Number each question:\n" + text
        service.sendPrompt(prompt) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let resp):
                    questions = resp.split(separator: "\n").map { String($0) }.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                case .failure(let err):
                    error = err.localizedDescription
                }
            }
        }
    }
}

#Preview {
    NavigationView { QuizGeneratorView(book: LibraryModel().books.first!) }
}
#endif
