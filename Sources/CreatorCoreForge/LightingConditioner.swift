import Foundation

/// Determines lighting presets from time, tone, and setting.
public struct LightingConditioner {
    public init() {}

    public func preset(forTimeOfDay time: String, tone: String, setting: String) -> String {
        let key = "\(time.lowercased())_\(tone.lowercased())_\(setting.lowercased())"
        return key
    }
}
