import Foundation

/// Generates common form templates from simple prompts.
public struct FormGenerator {
    public init() {}

    /// Auto-generates a login, register, or checkout form when prompt contains keywords.
    public func generateForm(from prompt: String) -> FormTemplate? {
        let lower = prompt.lowercased()
        if lower.contains("login") {
            return FormTemplate(name: "login", fields: [
                FormField(name: "email", type: .email, required: true),
                FormField(name: "password", type: .password, required: true)
            ])
        } else if lower.contains("register") {
            return FormTemplate(name: "register", fields: [
                FormField(name: "email", type: .email, required: true),
                FormField(name: "password", type: .password, required: true),
                FormField(name: "confirm", type: .password, required: true),
                FormField(name: "dob", type: .date, required: true)
            ])
        } else if lower.contains("checkout") {
            return FormTemplate(name: "checkout", fields: [
                FormField(name: "card", type: .text, required: true),
                FormField(name: "cvv", type: .number, required: true)
            ])
        }

        // Provide a minimal generic form when the prompt is unrecognized
        let field = FormField(name: "value", type: .text, required: false)
        return FormTemplate(name: "generic", fields: [field])
    }

    /// Validates input dictionary against required fields.
    public func validate(inputs: [String: String], for template: FormTemplate) -> Bool {
        for field in template.fields where field.required {
            if inputs[field.name]?.isEmpty ?? true {
                return false
            }
        }
        return true
    }
}
