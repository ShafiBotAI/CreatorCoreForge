import Foundation

/// Utility for verifying age eligibility for NSFW content.
public enum DOBCheck {
    /// Returns true if the birthdate meets the minimum age requirement.
    public static func isOfAge(birthdate: Date, minimumAge: Int = 18, calendar: Calendar = .current) -> Bool {
        let now = Date()
        let age = calendar.dateComponents([.year], from: birthdate, to: now).year ?? 0
        return age >= minimumAge
    }
}
