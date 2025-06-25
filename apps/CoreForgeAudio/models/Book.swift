import Foundation

/// Represents an audiobook with chapters and progress tracking.
struct Book: Identifiable, Codable {
    let id: UUID
    var title: String
    var author: String
    var coverImage: String?
    var chapters: [Chapter]
    var progress: Double
    var lastOpened: Date?

    init(id: UUID = UUID(),
         title: String,
         author: String,
         coverImage: String? = nil,
         chapters: [Chapter] = [],
         progress: Double = 0,
         lastOpened: Date? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.coverImage = coverImage
        self.chapters = chapters
        self.progress = progress
        self.lastOpened = lastOpened
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
