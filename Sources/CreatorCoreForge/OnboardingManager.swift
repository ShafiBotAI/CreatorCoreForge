import Foundation

/// Manages onboarding and tutorial steps for all apps.
public final class OnboardingManager {
    public struct Step: OptionSet {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }

        public static let welcome     = Step(rawValue: 1 << 0)
        public static let permissions = Step(rawValue: 1 << 1)
        public static let tutorial    = Step(rawValue: 1 << 2)
        public static let finished    = Step(rawValue: 1 << 3)
    }

    private let key = "OnboardingSteps"
    private let store: UserDefaults
    private var steps: Step

    public init(store: UserDefaults = .standard) {
        self.store = store
        if let raw = store.object(forKey: key) as? Int {
            steps = Step(rawValue: raw)
        } else {
            steps = []
        }
    }

    /// Mark a step as completed and persist it.
    public func complete(_ step: Step) {
        steps.insert(step)
        store.set(steps.rawValue, forKey: key)
    }

    /// Returns `true` if the step has been completed.
    public func isCompleted(_ step: Step) -> Bool {
        steps.contains(step)
    }
}
