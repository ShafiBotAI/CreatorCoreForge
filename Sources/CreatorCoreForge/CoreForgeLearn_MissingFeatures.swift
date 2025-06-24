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

public struct QuizBuilder {
    public struct Question {
        public let prompt: String
        public let answer: String
    }

    private var questions: [Question] = []

    public mutating func add(prompt: String, answer: String) {
        questions.append(Question(prompt: prompt, answer: answer))
    }

    public func grade(responses: [String]) -> Int {
        zip(questions, responses).filter { $0.answer == $1 }.count
    }
}

public struct CourseMarketplace {
    private var courses: [String] = []

    public mutating func publish(course: String) {
        courses.append(course)
    }

    public func list() -> [String] {
        courses
    }
}
