import Foundation

/// Injects fan avatars into scenes for fun cameos.
public struct FanCameoGenerator {
    public static func addCameo(for fanName: String, into scene: String) -> String {
        return scene + " featuring " + fanName
    }
}
