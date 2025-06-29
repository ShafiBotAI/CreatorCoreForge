import Foundation

/// Schedules outreach times based on a lead's timezone.
public struct TimezoneScheduler {
    public init() {}

    public func localSendTime(for lead: Lead, hour: Int) -> Date? {
        guard hour >= 0 && hour < 24 else { return nil }
        var comps = DateComponents()
        comps.hour = hour
        comps.timeZone = TimeZone(identifier: lead.region)
        return Calendar.current.date(from: comps)
    }
}
