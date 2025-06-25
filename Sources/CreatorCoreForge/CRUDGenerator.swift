import Foundation

/// Generates basic CRUD function names for a data model.
public struct CRUDGenerator {
    public init() {}

    public func generate(for model: String) -> [String] {
        ["create\(model)", "read\(model)", "update\(model)", "delete\(model)"]
    }
}
