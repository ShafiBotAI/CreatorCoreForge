#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge


/// Home library screen with featured carousel and sectioned book list.
=======
/// Modern dashboard-style library inspired by Speechify.

struct LibraryView: View {
    var namespace: Namespace.ID
    @EnvironmentObject var library: LibraryModel

    @State private var showImporter = false

    private var gradient: LinearGradient {
        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        BannerCarouselView()
                            .frame(height: 160)
                            .padding(.top)

                        if !library.books.isEmpty {
                            Text("My Books")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                                .foregroundColor(.white)
                            VStack(spacing: 12) {
                                ForEach(library.books) { book in
                                    BookCardView(book: book)
                                }
                            }
                            .padding(.horizontal)
                        }
=======
    @EnvironmentObject var usage: UsageStats

    @State private var query = ""
    @State private var sort = "Title"
    @State private var filters: Set<String> = []

    @State private var showPlayer = false

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
                        // Navigate to subscription view (placeholder)
                    }
                    ListeningStatsView(hoursThisWeek: usage.totalListeningTime / 3600,
                                       dailyStreak: 3,
                                       booksFinished: library.completedBooks.count,
                                       chaptersPlayed: library.books.flatMap { $0.chapters }.count)
                    dashboardSection("Continue Listening", books: library.inProgressBooks)
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

                .background(gradient.ignoresSafeArea())

                Button(action: { showImporter = true }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.25))
                        .clipShape(Circle())
                        .shadow(color: .white, radius: 4)
                }
                .padding()
=======
                .padding(.horizontal)

            }
        }
        .sheet(isPresented: $showImporter) {
            ImportView()
                .environmentObject(library)
        }
    }
}
#endif
