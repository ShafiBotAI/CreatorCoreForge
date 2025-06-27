#if canImport(SwiftUI)
import SwiftUI

/// Semi-transparent card styling for books.
struct BookCardView: View {
    var book: Book

    var body: some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            HStack {
                if let cover = book.coverImage {
                    Image(cover)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 90)
                        .clipped()
                } else {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 90)
                        .foregroundColor(.white)
                        .shadow(color: .white, radius: 2)
                }
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(book.author)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)
        }
    }
}

#Preview {
    BookCardView(book: Book(title: "Sample", author: "Author", chapters: []))
        .environmentObject(LibraryModel())
}
#endif
