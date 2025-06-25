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
}
