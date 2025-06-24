import Foundation

/// Provides a simple auto-remix shuffle for chapter order.
public final class AutoRemixMode {
    public init() {}

    public func remix(chapters: [Int]) -> [Int] {
        chapters.shuffled()
    }
}
