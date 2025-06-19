import Foundation

/// Determines if NSFW rendering is allowed for a given user based on age and settings.
final class NSFWPermissionManager {
    private let minimumAge: Int
    private var isNSFWEnabled: Bool

    init(minimumAge: Int = 18, enabled: Bool = false) {
        self.minimumAge = minimumAge
        self.isNSFWEnabled = enabled
    }

    func updateSetting(enabled: Bool) {
        self.isNSFWEnabled = enabled
    }

    func canRenderNSFW(age: Int) -> Bool {
        age >= minimumAge && isNSFWEnabled
    }
}
