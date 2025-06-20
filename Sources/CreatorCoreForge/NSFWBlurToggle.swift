import Foundation

/// Controls an age-gated blur overlay for NSFW scenes.
public final class NSFWBlurToggle {
    private let key = "NSFWBlurToggleState"
    private let store: UserDefaults
    public private(set) var isBlurred: Bool

    public init(store: UserDefaults = .standard) {
        self.store = store
        if store.object(forKey: key) == nil {
            self.isBlurred = true
        } else {
            self.isBlurred = store.bool(forKey: key)
        }
    }

    /// Attempt to toggle blur. Returns `false` if under age.
    @discardableResult
    public func toggle(birthdate: Date) -> Bool {
        guard DOBCheck.isOfAge(birthdate: birthdate) else { return false }
        isBlurred.toggle()
        store.set(isBlurred, forKey: key)
        return true
    }
}
