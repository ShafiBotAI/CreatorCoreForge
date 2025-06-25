import Foundation
#if canImport(AVFoundation)
import AVFoundation
import CoreVideo

public extension CMSampleBuffer {
    /// Convert this sample buffer into a CVPixelBuffer if possible.
    /// - Returns: Image buffer associated with this sample buffer or nil.
    func toPixelBuffer() -> CVPixelBuffer? {
        CMSampleBufferGetImageBuffer(self)
    }
}
#endif
