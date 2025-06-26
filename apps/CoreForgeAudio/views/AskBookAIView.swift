#if canImport(SwiftUI)
import SwiftUI

/// AI chat Q&A about selected content.
struct AskBookAIView: View {
    @State private var question = ""
    @State private var responses: [String] = []

    var body: some View {
        VStack {
            List(responses, id: \..self) { Text($0) }
            HStack {
                TextField("Ask a question", text: $question)
                    .textFieldStyle(.roundedBorder)
                Button("Send") {
                    responses.append(question)
                    question = ""
                }
            }
            .padding()
        }
        .navigationTitle("Ask Book AI")
    }
}

#Preview {
    NavigationView { AskBookAIView() }
}
#endif
