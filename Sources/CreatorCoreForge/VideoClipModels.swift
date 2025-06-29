import Foundation

/// Metadata for a small scene clip extracted from the book.
public struct SceneClip {
    public let clipID: String
    public let text: String
    public let sceneIndex: Int
    public let startLine: Int
    public let endLine: Int
    public let tone: String
    public let transitionType: String

    public init(clipID: String,
                text: String,
                sceneIndex: Int,
                startLine: Int,
                endLine: Int,
                tone: String,
                transitionType: String) {
        self.clipID = clipID
        self.text = text
        self.sceneIndex = sceneIndex
        self.startLine = startLine
        self.endLine = endLine
        self.tone = tone
        self.transitionType = transitionType
    }
}

/// Simple mapping from character name to assigned voice label.
public typealias VoiceMap = [String: String]

/// Represents the final stitched video.
public struct FinalVideo {
    public let frames: [String]
    public init(frames: [String]) { self.frames = frames }
}
