import Foundation

/// Inserts intermediate frames between existing frames for smoother playback.
public struct FrameInterpolationService {
    public init() {}

    /// Simple string-based interpolation. In a real engine this would apply
    /// pixel or vector blending. Here we just insert labelled placeholders.
    public func interpolate(frames: [String], factor: Int) -> [String] {
        guard factor > 1 else { return frames }
        var output: [String] = []
        for i in 0..<frames.count-1 {
            let a = frames[i]
            let b = frames[i+1]
            output.append(a)
            for j in 1..<factor {
                output.append("\(a)->\(b)#\(j)")
            }
        }
        if let last = frames.last {
            output.append(last)
        }
        return output
    }
}
