import Foundation

/// Handles date-of-birth verification in combination with NSFW settings.
public struct AgeCheckNSFWGate {
    public init() {}

    public func isAccessAllowed(nsfwEnabled: Bool, birthDate: Date, minimumAge: Int = 18) -> Bool {
        let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        guard age >= minimumAge else { return false }
        return NSFWGuard.isAllowed(nsfwEnabled: nsfwEnabled, birthDate: birthDate, minimumAge: minimumAge)
    }
}
