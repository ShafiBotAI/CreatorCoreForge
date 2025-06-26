#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Fun reader tools placeholder row.
struct ExploreWidgetRow: View {
    @State private var showAlert = false
    var body: some View {
        HStack {
            Image(systemName: "sparkles")
            Text("Voice Mashups")
            Spacer()
            Button("Try") { showAlert = true }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
        .alert("Coming Soon", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

#Preview {
    ExploreWidgetRow()
}
#endif
