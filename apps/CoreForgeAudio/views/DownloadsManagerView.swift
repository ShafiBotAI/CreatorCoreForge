#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Lists downloaded books and shows space usage.
struct DownloadsManagerView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var offline: OfflineContentManager
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
                        offline.remove(book: book)
                        storageUsed = calculateStorage()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }

        .onAppear { storageUsed = calculateStorage() }
=======
        .onAppear {
            storageUsed = Double(offline.downloaded.count) * 50
        }

        .padding(.vertical)
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }

    private func calculateStorage() -> Double {
        var bytes: Int64 = 0
        for url in offline.downloaded {
            if let attrs = try? FileManager.default.attributesOfItem(atPath: url.path),
               let size = attrs[.size] as? NSNumber {
                bytes += size.int64Value
            }
        }
        return Double(bytes) / 1_048_576
    }
}

#Preview {
    DownloadsManagerView()
        .environmentObject(LibraryModel())
        .environmentObject(OfflineContentManager(library: LibraryModel()))
}
#endif
