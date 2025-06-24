import Foundation

/// Converts form templates to JSON schema for reuse.
public struct FormExporter {
    public init() {}
    public func export(template: FormTemplate) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(template)
        return String(data: data ?? Data(), encoding: .utf8) ?? ""
    }
}
