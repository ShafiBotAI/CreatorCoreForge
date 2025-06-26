#if canImport(SwiftUI)
import SwiftUI

/// Auto-generated summary of a book.
struct BookSummaryView: View {
    var body: some View {
        ScrollView {
            Text("Sample summary text for the selected book. This view would fetch AI-generated content in the full app.")
                .padding()
        }
        .navigationTitle("Summary")
    }
}

#Preview {
    NavigationView { BookSummaryView() }
}
#endif
