#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Fun reader tools placeholder row.
struct ExploreWidgetRow: View {
    var body: some View {
        HStack {
            Image(systemName: "sparkles")
            Text("Voice Mashups")
            Spacer()
            Button("Try") { }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}

#Preview {
    ExploreWidgetRow()
}
#endif
