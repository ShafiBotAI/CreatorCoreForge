#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Fun reader tools row to access voice mashups.
struct ExploreWidgetRow: View {
    @State private var showMashup = false
    var body: some View {
        HStack {
            Image(systemName: "sparkles")
            Text("Voice Mashups")
            Spacer()
            Button("Try") { showMashup = true }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
        .sheet(isPresented: $showMashup) {
            NavigationView { VoiceMashupView() }
        }
    }
}

#Preview {
    ExploreWidgetRow()
}
#endif
