#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Buttons for importing from various sources.
struct ImportShortcutsPanel: View {
    var body: some View {
        HStack {
            ForEach(Source.allCases, id: \..self) { source in
                Button(action: { /* placeholder */ }) {
                    VStack {
                        Image(systemName: source.icon)
                        Text(source.title).font(.caption2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }

    enum Source: CaseIterable {
        case files, web, gmail, scan, links
        var title: String {
            switch self { case .files: return "Files"; case .web: return "Web"; case .gmail: return "Gmail"; case .scan: return "Scan"; case .links: return "Links" }
        }
        var icon: String {
            switch self { case .files: return "doc"; case .web: return "globe"; case .gmail: return "envelope"; case .scan: return "camera.viewfinder"; case .links: return "link" }
        }
    }
}

#Preview {
    ImportShortcutsPanel()
}
#endif
