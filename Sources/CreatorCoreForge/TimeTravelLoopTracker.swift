import Foundation

/// Tracks visited years and reports paradox loops.
public final class TimeTravelLoopTracker {
    private var years: Set<Int> = []
    public init() {}

    /// Records a time jump. Returns true if a paradox loop is detected.
    public func recordJump(to year: Int) -> Bool {
        let existed = years.contains(year)
        years.insert(year)
        return existed
    }
}
