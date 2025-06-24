import Foundation

/// Small in-memory curriculum manager capable of building and
/// exporting simple course structures to JSON. This replaces the
/// earlier placeholder with basic persistence utilities.
public struct CurriculumDesigner {

    public struct Lesson: Codable {
        public var title: String
        public var quiz: [String]
    }

    public struct Course: Codable {
        public var title: String
        public var lessons: [Lesson]
    }

    private var courses: [Course] = []

    public init() {}

    /// Build a course and store it in memory.
    @discardableResult
    public mutating func buildCourse(title: String, lessons: [Lesson]) -> Course {
        let course = Course(title: title, lessons: lessons)
        courses.append(course)
        return course
    }

    /// Export all stored courses as JSON data.
    public func export() -> Data? {
        try? JSONEncoder().encode(courses)
    }

    /// Load courses from previously exported JSON data.
    public mutating func load(from data: Data) {
        if let decoded = try? JSONDecoder().decode([Course].self, from: data) {
            courses = decoded
        }
    }

    /// Retrieve all courses in memory.
    public var allCourses: [Course] { courses }
}
