import Foundation

/// Represents a single form field.
public struct FormField: Codable, Equatable {
    public enum FieldType: String, Codable {
        case text
        case password
        case email
        case number
        case date
    }
    public var name: String
    public var type: FieldType
    public var required: Bool
    public init(name: String, type: FieldType, required: Bool = false) {
        self.name = name
        self.type = type
        self.required = required
    }
}

/// Template describing a form layout.
public struct FormTemplate: Codable, Equatable {
    public var name: String
    public var fields: [FormField]
    public init(name: String, fields: [FormField]) {
        self.name = name
        self.fields = fields
    }
}
