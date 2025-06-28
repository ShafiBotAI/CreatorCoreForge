import Foundation

/// Represents an audiobook with chapters and progress tracking.
struct Book: Identifiable, Codable {
    let id: UUID
    var title: String
    var author: String
    /// Optional series name for sequels or related books.
    var series: String?
    var coverImage: String?
    var chapters: [Chapter]
    var progress: Double
    var lastOpened: Date?
    var isDownloaded: Bool
    var isFavorite: Bool

    init(id: UUID = UUID(),
         title: String,
         author: String,
         series: String? = nil,
         coverImage: String? = nil,
         chapters: [Chapter] = [],
         progress: Double = 0,
         lastOpened: Date? = nil,
         isDownloaded: Bool = false,
         isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.author = author
        self.series = series
        self.coverImage = coverImage
        self.chapters = chapters
        self.progress = progress
        self.lastOpened = lastOpened
        self.isDownloaded = isDownloaded
        self.isFavorite = isFavorite
    }
}

/// Basic chapter model used by `Book`.
struct Chapter: Identifiable, Codable {
    let id: UUID
    var title: String
    var text: String
    var audioURL: URL?

    init(id: UUID = UUID(),
         title: String,
         text: String,
         audioURL: URL? = nil) {
        self.id = id
        self.title = title
        self.text = text
        self.audioURL = audioURL
    }
}
