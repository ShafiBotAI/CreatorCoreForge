import Foundation

/// Generates a simple text preview of a scene mix.
public struct AmbientPreviewer {
    public static func preview(scene: String, voice: String, fx: [String]) -> String {
        let fxList = fx.joined(separator: ",")
        return "Preview(voice:\(voice), fx:[\(fxList)], scene:\(scene))"
    }
}
