import Foundation

/// Generic timeline editor for arranging clips.
public final class TimelineEditor<Clip> {
    private var clips: [Clip] = []
    public init() {}

    public func addClip(_ clip: Clip) {
        clips.append(clip)
    }

    public func timeline() -> [Clip] {
        clips
    }
}

