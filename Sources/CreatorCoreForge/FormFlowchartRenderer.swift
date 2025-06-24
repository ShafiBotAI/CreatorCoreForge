import Foundation

/// Generates a simple textual flowchart for a form's navigation.
public struct FormFlowchartRenderer {
    public init() {}
    public func render(template: FormTemplate) -> String {
        let arrows = template.fields.map { $0.name }.joined(separator: " -> ")
        return "Start -> " + arrows
    }
}
