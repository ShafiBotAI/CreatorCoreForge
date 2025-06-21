import Foundation

public typealias AudioBlob = Data

/// Simple TTS renderer that encodes text with a voice prefix.
public struct TTSService {
    public init() {}

    public func renderSegment(_ segment: Segment, voiceId: String) -> AudioBlob {
        let string = "voice:\(voiceId)\n\(segment.text)"
        return Data(string.utf8)
    }
}

