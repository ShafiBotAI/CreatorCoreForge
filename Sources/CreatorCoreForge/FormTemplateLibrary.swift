import Foundation

/// Stores and retrieves reusable form templates.
public final class FormTemplateLibrary {
    private var templates: [String: FormTemplate] = [:]
    public init() {}

    public func addTemplate(_ template: FormTemplate) {
        templates[template.name] = template
    }

    public func template(named name: String) -> FormTemplate? {
        templates[name]
    }
}
