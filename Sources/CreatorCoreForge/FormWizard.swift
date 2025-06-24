import Foundation

/// Represents a single step in a multi-step form wizard.
public struct FormStep {
    public let template: FormTemplate
    public let condition: (([String: String]) -> Bool)?
    public init(template: FormTemplate, condition: (([String: String]) -> Bool)? = nil) {
        self.template = template
        self.condition = condition
    }
}

/// Handles progression through a sequence of form steps.
public final class FormWizard {
    private let binding: InputBindingEngine
    public private(set) var steps: [FormStep]
    public private(set) var currentIndex: Int = 0

    public init(steps: [FormStep], binding: InputBindingEngine = InputBindingEngine()) {
        self.steps = steps
        self.binding = binding
    }

    /// Returns the currently active form template.
    public var currentStep: FormTemplate? {
        guard currentIndex < steps.count else { return nil }
        return steps[currentIndex].template
    }

    /// Advance to the next step if available and any condition is met.
    public func next() {
        let nextIndex = currentIndex + 1
        guard nextIndex < steps.count else { return }
        let nextStep = steps[nextIndex]
        if let condition = nextStep.condition {
            if condition(binding.allValues) {
                currentIndex = nextIndex
            }
        } else {
            currentIndex = nextIndex
        }
    }

    /// Move back to the previous step.
    public func previous() {
        currentIndex = max(0, currentIndex - 1)
    }
}
