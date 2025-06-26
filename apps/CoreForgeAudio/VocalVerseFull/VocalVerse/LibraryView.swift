#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Modern dashboard-style library inspired by Speechify.
struct LibraryView: View {
    var namespace: Namespace.ID
    @EnvironmentObject var library: LibraryModel
    @EnvironmentObject var usage: UsageStats

    @State private var query = ""
    @State private var sort = "Title"
    @State private var filters: Set<String> = []

    @State private var showPlayer = false
    @State private var showUpgrade = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 20) {
                    Color.clear
                        .frame(height: 0)
                        .matchedGeometryEffect(id: "start", in: namespace)
                    FeaturedCarouselView(books: library.books)
                    SearchView(query: $query, sort: $sort, filters: $filters)
                    ProfileTierCardView(userName: "User", tier: usage.subscriptionTier) {
                        showUpgrade = true
                    }
                    ListeningStatsView(hoursThisWeek: usage.totalListeningTime / 3600,
                                       dailyStreak: 3,
                                       booksFinished: library.books.filter { $0.progress >= 1 }.count,
                                       chaptersPlayed: library.books.flatMap { $0.chapters }.count)
                    dashboardSection("Continue Listening", books: library.books.filter { $0.progress > 0 && $0.progress < 1 })
                    dashboardSection("Recommended For You", books: library.books)
                    dashboardSection("Recently Added", books: library.books)
                    dashboardSection("Favorites", books: library.books)
                    chaptersProgressSection()
                }
            }
            if let book = library.currentBook, let chapter = library.currentChapter {
                if showPlayer {
                    PlayerView(namespace: namespace)
                        .environmentObject(library)
                        .environmentObject(usage)
                        .transition(.move(edge: .bottom))
                        .background(Color(.systemBackground))
                        .matchedGeometryEffect(id: "player", in: namespace)
                } else {
                    MiniPlayerView(book: book, chapter: chapter, namespace: namespace, isExpanded: $showPlayer)
                        .padding()
                }
            }
        }
        .sheet(isPresented: $showUpgrade) {
            SubscriptionUpgradeView { plan in
                usage.subscriptionTier = plan.rawValue
                showUpgrade = false
            }
        }
    }

    private func dashboardSection(_ title: String, books: [Book]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            FeaturedCarouselView(books: books)
        }
    }

    private func chaptersProgressSection() -> some View {
        VStack(alignment: .leading) {
            Text("Chapters In Progress")
                .font(.headline)
                .padding(.horizontal)
            ForEach(library.books.flatMap { $0.chapters }.filter { _ in true }) { chapter in
                HStack {
                    Text(chapter.title)
                    Spacer()
                    Button("Resume") {
                        library.currentBook = library.books.first
                        library.currentChapter = chapter
                        showPlayer = true
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
    }
}
#endif
