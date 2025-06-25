#if canImport(SwiftUI)
import SwiftUI

/// Displays details for a selected book with chapter list and voice casting.
struct BookDetailView: View {
    @State private var showVoiceCast = false
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
                }
            }
        }
        .toolbar {
            Button("Voices") { showVoiceCast = true }
        }
        .sheet(isPresented: $showVoiceCast) {
            VoiceCastView(characters: extractCharacters(from: book))
        }
    }

    private func extractCharacters(from book: Book) -> [String] {
        // Very naive character detection placeholder
        var set = Set<String>()
        for chapter in book.chapters {
            chapter.text.split(separator: " ").forEach { word in
                if word.hasPrefix("@") {
                    set.insert(String(word.dropFirst()))
                }
            }
        }
        return Array(set)
    }
}
#endif
