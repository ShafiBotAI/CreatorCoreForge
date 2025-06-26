import Foundation

/// Generates mock input data for a form template.
public struct MockDataGenerator {
    public init() {}
    public func generate(for template: FormTemplate) -> [String: String] {
        var data: [String: String] = [:]
        for field in template.fields {
            switch field.type {
            case .email:
                data[field.name] = "test@example.com"
            case .password:
                data[field.name] = "password"
            case .number:
                data[field.name] = "123"
            case .date:
                let formatter = ISO8601DateFormatter()
                data[field.name] = formatter.string(from: Date())
            case .text:
                data[field.name] = field.name.capitalized
            }
        }
        return data
    }
}
