#if canImport(SwiftUI)
import SwiftUI

/// Generates comprehension quizzes per book.
struct QuizGeneratorView: View {
    var body: some View {
        Form {
            Section("Generate Quiz") {
                Button("Create Sample Quiz") { }
            }
        }
        .navigationTitle("Quiz Generator")
    }
}

#Preview {
    NavigationView { QuizGeneratorView() }
}
#endif
