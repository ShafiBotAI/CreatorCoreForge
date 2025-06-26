#if canImport(SwiftUI)
import SwiftUI

/// Entry screen for smart tools and AI widgets.
struct AIExploreView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Book Summary") { BookSummaryView() }
                NavigationLink("Quiz Generator") { QuizGeneratorView() }
                NavigationLink("Ask Book AI") { AskBookAIView() }
            }
            .navigationTitle("AI Explore")
        }
    }
}

#Preview {
    AIExploreView()
}
#endif
