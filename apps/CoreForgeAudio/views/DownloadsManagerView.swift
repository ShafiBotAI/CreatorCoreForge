#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Lists downloaded books and shows space usage.
struct DownloadsManagerView: View {
    @EnvironmentObject var library: LibraryModel
    @State private var storageUsed: Double = 0

    private var downloaded: [Book] {
        library.books.filter { $0.isDownloaded }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Offline Content")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.0f MB used", storageUsed))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            ForEach(downloaded) { book in
                HStack {
                    Text(book.title)
                    Spacer()
                    Button("Remove") {
                        library.removeDownloaded(book: book)
                        storageUsed = calculateStorage()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
        .onAppear { storageUsed = calculateStorage() }
        .padding(.vertical)
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }

    private func calculateStorage() -> Double {
        var bytes: Int64 = 0
        for book in downloaded {
            for chapter in book.chapters {
                if let url = chapter.audioURL,
                   let attrs = try? FileManager.default.attributesOfItem(atPath: url.path),
                   let size = attrs[.size] as? NSNumber {
                    bytes += size.int64Value
                }
            }
        }
        return Double(bytes) / 1_048_576
    }
}

#Preview {
    DownloadsManagerView()
        .environmentObject(LibraryModel())
}
#endif
