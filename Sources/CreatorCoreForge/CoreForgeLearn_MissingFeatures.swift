import Foundation

public struct CurriculumBuilder {
    public func makeLesson(from text: String) -> [String] {
        text.split(separator: ".").map { String($0.trimmingCharacters(in: .whitespaces)) }.filter { !$0.isEmpty }
    }
}

public struct AITutor {
    public func feedback(score: Int) -> String {
        score > 80 ? "Great job" : "Keep practicing"
    }
}

public struct OfflineSync {
    private var cache: [String] = []
    public mutating func add(_ record: String) { cache.append(record) }
    public var count: Int { cache.count }
}
