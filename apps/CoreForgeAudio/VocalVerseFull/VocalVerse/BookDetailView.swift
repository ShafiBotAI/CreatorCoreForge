#if canImport(SwiftUI)
import SwiftUI

/// Displays details for a selected book with chapter list and voice casting.
struct BookDetailView: View {
    @State private var showVoiceCast = false
    @EnvironmentObject var library: LibraryModel
    var book: Book

    var body: some View {
        List {
            if let cover = book.coverImage {
                Image(cover)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            Text(book.title)
                .font(.title)
            Text("by \(book.author)")
                .foregroundColor(.secondary)
            ProgressView(value: book.progress)
            Section(header: Text("Chapters")) {
                ForEach(book.chapters) { chapter in
                    HStack {
                        Text(chapter.title)
                        Spacer()
                        if chapter.audioURL != nil {
                            Image(systemName: "waveform")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        library.select(book: book, chapter: chapter)
                    }
                }
            }
        }
        .toolbar {
            Button("Voices") { showVoiceCast = true }
            Button("Play") {
                library.select(book: book, chapter: book.chapters.first)
            }
        }
        .sheet(isPresented: $showVoiceCast) {
            VoiceCastView(characters: extractCharacters(from: book))
        }
    }

    private func extractCharacters(from book: Book) -> [String] {
        var counts: [String: Int] = [:]
        for chapter in book.chapters {
            let tokens = chapter.text.split { !$0.isLetter }
            for token in tokens {
                let word = String(token)
                guard word.first?.isUppercase == true, word.count > 1 else { continue }
                counts[word, default: 0] += 1
            }
        }
        return counts.filter { $0.value > 1 }.map { $0.key }
    }
}
#endif
