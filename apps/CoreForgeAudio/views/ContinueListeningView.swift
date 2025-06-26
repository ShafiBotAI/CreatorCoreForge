#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Displays the most recently opened books for quick resumption.
struct ContinueListeningView: View {
    @EnvironmentObject var library: LibraryModel

    private var recent: [Book] {
        Array(library.books
            .sorted { ($0.lastOpened ?? .distantPast) > ($1.lastOpened ?? .distantPast) }
            .prefix(3))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Continue Listening")
                .font(.headline)
                .padding(.horizontal)
            ForEach(recent) { book in
                HStack {
                    Text(book.title)
                    Spacer()
                    if let chapter = book.chapters.first(where: { $0.id == library.currentChapter?.id }) {
                        Text(chapter.title).font(.caption).foregroundColor(.secondary)
                    }
                    Button("Resume") {
                        library.select(book: book, chapter: book.chapters.first)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}

#Preview {
    ContinueListeningView()
        .environmentObject(LibraryModel())
}
#endif
