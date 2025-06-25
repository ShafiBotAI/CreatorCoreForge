#if canImport(SwiftUI)
import SwiftUI

/// Home library screen with featured carousel and sectioned book list.
struct LibraryView: View {
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
                    }
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
            }
            .navigationTitle("Library")
        }
        .sheet(isPresented: $showImporter) {
            ImportView()
                .environmentObject(library)
        }
    }
}
#endif
