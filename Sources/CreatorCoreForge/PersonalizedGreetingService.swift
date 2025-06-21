import Foundation

/// Generates simple personalized greetings.
public final class PersonalizedGreetingService {
    public init() {}

    public func greeting(for name: String) -> String {
        "Hello, \(name)!"
    }
}
