#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Shows the most recently imported books.
struct RecentlyImportedView: View {
    @EnvironmentObject var library: LibraryModel

    private var recent: [Book] {
        Array(library.books.sorted { ($0.lastOpened ?? .distantPast) > ($1.lastOpened ?? .distantPast) }.prefix(3))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recently Imported")
                .font(.headline)
                .padding(.horizontal)
            ForEach(recent) { book in
                Text(book.title)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical)
        .background(AppTheme.cardMaterial)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(radius: AppTheme.shadowRadius)
    }
}

#Preview {
    RecentlyImportedView()
        .environmentObject(LibraryModel())
}
#endif
