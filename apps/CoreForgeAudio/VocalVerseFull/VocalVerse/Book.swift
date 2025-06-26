import Foundation

struct Book: Identifiable, Codable {
    let id: UUID = UUID()
    var title: String
    var author: String
    var chapters: [Chapter]
}

struct Chapter: Identifiable, Codable {
    let id: UUID = UUID()
    var title: String
    var text: String
}
