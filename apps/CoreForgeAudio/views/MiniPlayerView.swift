#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Collapsed player pinned to the bottom of `LibraryDashboardView`.
struct MiniPlayerView: View {
    var book: Book
    var chapter: Chapter
    var namespace: Namespace.ID
    @Binding var isExpanded: Bool
    @State private var isPlaying = false

    var body: some View {
        Theme.card {
            HStack {
                Text(chapter.title.isEmpty ? book.title : chapter.title)
                    .font(.subheadline)
                    .lineLimit(1)
                Spacer()
                Button(action: { isPlaying.toggle() }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .imageScale(.medium)
                        .foregroundColor(.primary)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(AppTheme.primaryGradient)
        .matchedGeometryEffect(id: "player", in: namespace)
        .onTapGesture { isExpanded = true }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @Namespace var ns
        @State var expanded = false

        var body: some View {
            MiniPlayerView(
                book: Book(title: "Sample Book", author: "Author", series: nil),
                chapter: Chapter(title: "Chapter 1", text: "Sample"),
                namespace: ns,
                isExpanded: $expanded
            )
        }
    }
    return PreviewWrapper()
}
#endif
