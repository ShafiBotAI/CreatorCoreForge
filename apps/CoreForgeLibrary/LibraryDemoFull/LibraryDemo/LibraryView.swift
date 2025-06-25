import Foundation
#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

struct LibraryView: View {
    @State private var query = ""
    @State private var sort = "Title"
    @State private var filters: Set<String> = []

    @State private var featured = demoBooks
    @State private var continueListening = demoBooks
    @State private var recommended = demoBooks
    @State private var recent = demoBooks
    @State private var favorites = demoBooks
    @State private var progressChapters: [Chapter] = demoBooks.first?.chapters ?? []

    @State private var showPlayer = false
    @State private var currentBook: Book?
    @State private var currentChapter: Chapter?

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 20) {
                    FeaturedCarouselView(books: featured)
                    SearchView(query: $query, sort: $sort, filters: $filters)
                    ProfileTierCardView(userName: "Demo User", tier: "Free") {}
                    ListeningStatsView(hoursThisWeek: 2.5, dailyStreak: 3, booksFinished: 1, chaptersPlayed: 5)
                    dashboardSection("Continue Listening", books: continueListening)
                    dashboardSection("Recommended For You", books: recommended)
                    dashboardSection("Recently Added", books: recent)
                    dashboardSection("Favorites", books: favorites)
                    chaptersProgressSection()
                }
            }
            if let book = currentBook, let chapter = currentChapter {
                if showPlayer {
                    PlayerView(isPresented: $showPlayer, book: book, chapter: chapter)
                        .transition(.move(edge: .bottom))
                        .background(Color(.systemBackground))
                } else {
                    MiniPlayerView(book: book, chapter: chapter, isExpanded: $showPlayer)
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
            ForEach(progressChapters) { chapter in
                HStack {
                    Text(chapter.title)
                    Spacer()
                    Button("Resume") {
                        currentBook = featured.first
                        currentChapter = chapter
                        showPlayer = true
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
            }
        }
    }
}

private let demoBooks: [Book] = [
    Book(title: "Sample Adventure", author: "A. Author", chapters: [
        Chapter(title: "Intro", text: "Welcome to the adventure."),
        Chapter(title: "Conflict", text: "The story continues.")
    ]),
    Book(title: "Mystery Night", author: "B. Writer", chapters: [
        Chapter(title: "Start", text: "It was a dark night."),
        Chapter(title: "Clue", text: "A clue appears.")
    ])
]

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
#endif

