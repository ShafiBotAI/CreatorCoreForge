#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Auto-generates a short summary for the provided book using OpenAI.
struct BookSummaryView: View {
    var book: Book
    @State private var summary: String = ""
    @State private var isLoading = false
    @State private var error: String?
    private let service = AISummaryChatService(service: OpenAIService(environmentKey: "OPENAI_API_KEY"))

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
                    .padding()
            } else if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text(summary)
                    .padding()
            }
        }
        .navigationTitle("Summary")
        .task { await generateSummary() }
    }

    private func generateSummary() async {
        guard summary.isEmpty else { return }
        isLoading = true
        let text = book.chapters.map { $0.text }.joined(separator: " ")
        await withCheckedContinuation { continuation in
            service.summarize(text) { result in
                DispatchQueue.main.async {
                    isLoading = false
                    switch result {
                    case .success(let s):
                        summary = s
                    case .failure(let err):
                        error = err.localizedDescription
                    }
                    continuation.resume()
                }
            }
        }
    }
}

#Preview {
    NavigationView { BookSummaryView(book: LibraryModel().books.first!) }
        .environmentObject(LibraryModel())
}
#endif
