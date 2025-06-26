#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Tiles showing current in-progress chapters with resume actions.
struct ChapterProgressView: View {
    @EnvironmentObject var library: LibraryModel
    @Binding var showPlayer: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Chapters In Progress")
                .font(.headline)
                .padding(.horizontal)
            ForEach(library.books) { book in
                ForEach(book.chapters) { chapter in
                    HStack {
                        Text(chapter.title)
                        Spacer()
                        Button("Resume") {
                            library.currentBook = book
                            library.currentChapter = chapter
                            showPlayer = true
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}
#endif
