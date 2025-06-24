import Foundation

/// Parses simple Figma JSON exports to generate view names.
public struct FigmaUIBuilder {
    public init() {}

    /// Return an array of node names found in the provided JSON string.
    public func generateViews(from json: String) -> [String] {
        guard let data = json.data(using: .utf8),
              let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let nodes = obj["nodes"] as? [[String: Any]] else {
            return []
        }
        return nodes.compactMap { $0["name"] as? String }
    }
}
