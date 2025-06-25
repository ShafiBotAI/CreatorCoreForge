import Foundation

/// Dynamically segments raw text into voice-ready blocks using `SegmentService`.
public final class SegmentEngine {
    private let service: SegmentService

    public init(service: SegmentService = SegmentService()) {
        self.service = service
    }

    /// Segment text synchronously.
    public func segments(from text: String) -> [Segment] {
        service.segment([Chapter(title: "", text: text)])
    }

    /// Segment text asynchronously.
    public func segmentsAsync(from text: String, completion: @escaping ([Segment]) -> Void) {
        service.segmentAsync([Chapter(title: "", text: text)], completion: completion)
    }

    /// Dynamically split text using punctuation for finer voice blocks.
    public func dynamicSegments(from text: String) -> [Segment] {
        var segments: [Segment] = []
        var buffer = ""
        for ch in text {
            buffer.append(ch)
            if ".!?".contains(ch) {
                let trimmed = buffer.trimmingCharacters(in: .whitespacesAndNewlines)
                if !trimmed.isEmpty {
                    segments.append(Segment(text: trimmed))
                }
                buffer.removeAll()
            }
        }
        let tail = buffer.trimmingCharacters(in: .whitespacesAndNewlines)
        if !tail.isEmpty { segments.append(Segment(text: tail)) }
        return segments
    }
}
