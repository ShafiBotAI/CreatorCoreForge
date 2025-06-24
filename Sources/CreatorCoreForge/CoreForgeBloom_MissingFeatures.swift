import Foundation

public struct CycleTracker {
    public func predict(last: Date, cycleLength: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: cycleLength, to: last) ?? last
    }
}

public struct WellnessReminder {
    public func remind(_ note: String) -> String {
        "Reminder: \(note)"
    }
}

public struct WearableSync {
    public func sync(data: [String: Int]) -> Int {
        data.values.reduce(0, +)
    }
}
