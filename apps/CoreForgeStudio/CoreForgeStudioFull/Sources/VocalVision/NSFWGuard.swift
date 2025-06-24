import Foundation

/// Simple age check for NSFW content access.
public struct NSFWGuard {
    public static func isAllowed(nsfwEnabled: Bool, birthDate: Date, minimumAge: Int = 18) -> Bool {
        guard nsfwEnabled else { return false }
        let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        return age >= minimumAge
    }
}
