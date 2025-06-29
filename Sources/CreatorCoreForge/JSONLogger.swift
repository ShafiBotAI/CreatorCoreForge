import Foundation

public struct JSONLogger {
    public static func log(_ message: String, metadata: [String: String] = [:]) {
        var meta = metadata
        if let token = meta["token"] { meta["token"] = String(repeating: "*", count: max(4, token.count)) }
        let entry: [String: Any] = ["message": message, "metadata": meta, "timestamp": ISO8601DateFormatter().string(from: Date())]
        if let data = try? JSONSerialization.data(withJSONObject: entry), let json = String(data: data, encoding: .utf8) {
            print(json)
        }
    }
}
