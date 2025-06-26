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
                        // Placeholder remove action
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            storageUsed = Double(offline.downloaded.count) * 50
        }
        .padding(.vertical)
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}

#Preview {
    DownloadsManagerView()
        .environmentObject(LibraryModel())
        .environmentObject(OfflineContentManager(library: LibraryModel()))
}
#endif
