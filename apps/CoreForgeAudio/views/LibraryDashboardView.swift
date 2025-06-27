#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Main home screen layout showing featured books and search.
struct LibraryDashboardView: View {
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats
    @Namespace private var ns

    @State private var query = ""
    @State private var sort = "Title"
    @State private var filters: Set<String> = []
    @State private var showPlayer = false
    @State private var showUpgrade = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                if library.books.isEmpty {
                    EmptyStateView(systemImage: "books.vertical", message: "Your library is empty")
                } else {
                    VStack(spacing: 20) {
                        FeaturedCarouselView(books: library.books)
                            .environmentObject(library)
                    SearchView(query: $query, sort: $sort, filters: $filters)
                    ProfileTierCardView(userName: "User", tier: usage.subscriptionTier) {
                        showUpgrade = true
                    }
                    ContinueListeningView()
                        .environmentObject(library)
                    RecentlyImportedView()
                        .environmentObject(library)
                    ListeningStatsView(
                        hoursThisWeek: usage.totalListeningTime / 3600,
                        dailyStreak: 3,
                        booksFinished: library.completedBooks.count,
                        chaptersPlayed: library.books.flatMap { $0.chapters }.count
                    )
                    if !library.favoriteBooks.isEmpty {
                        FavoritesCarouselView()
                            .environmentObject(library)
                    }
                    DownloadsManagerView()
                        .environmentObject(library)
                        ChapterProgressView(showPlayer: $showPlayer)
                            .environmentObject(library)
                    }
                }
            }
            if let book = library.currentBook, let chapter = library.currentChapter {
                if showPlayer {
                    PlayerView(namespace: ns)
                        .environmentObject(library)
                        .environmentObject(usage)
                        .transition(.scale)
                        .background(Theme.cardMaterial)
                        .cornerRadius(Theme.cornerRadius)
                        .shadow(radius: Theme.shadowRadius)
                } else {
                    MiniPlayerView(book: book, chapter: chapter, namespace: ns, isExpanded: $showPlayer)
                        .padding()
                        .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut, value: showPlayer)
        .sheet(isPresented: $showUpgrade) {
            SubscriptionUpgradeView { plan in
                usage.subscriptionTier = plan.rawValue
                showUpgrade = false
            }
        }
    }
}

#Preview {
    LibraryDashboardView()
        .environmentObject(LibraryModel())
        .environmentObject(UsageStats())
}
#endif
