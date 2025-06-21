import Foundation

/// Stores user-created annotations tied to timestamps.
public struct UserAnnotation: Codable, Equatable {
    public let id: UUID
    public let time: TimeInterval
    public let text: String
    public init(id: UUID = UUID(), time: TimeInterval, text: String) {
        self.id = id
        self.time = time
        self.text = text
    }
}

public final class UserAnnotations {
    private(set) var annotations: [UserAnnotation] = []
    public init() {}

    /// Add a new annotation.
    public func add(_ annotation: UserAnnotation) {
        annotations.append(annotation)
    }

    /// Remove all annotations.
    public func clear() {
        annotations.removeAll()
    }
}
