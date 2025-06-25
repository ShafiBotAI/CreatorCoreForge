import XCTest
@testable import CreatorCoreForge

final class CMSampleBufferExtensionsTests: XCTestCase {
    #if canImport(AVFoundation)
    func testToPixelBuffer() {
        var buffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, 2, 2, kCVPixelFormatType_32ARGB, nil, &buffer)
        XCTAssertEqual(status, kCVReturnSuccess)
        guard let pixel = buffer else {
            XCTFail("Pixel buffer not created")
            return
        }
        var format: CMFormatDescription?
        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: pixel, formatDescriptionOut: &format)
        var timing = CMSampleTimingInfo(duration: .invalid,
                                        presentationTimeStamp: .zero,
                                        decodeTimeStamp: .invalid)
        var sample: CMSampleBuffer?
        CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault,
                                           imageBuffer: pixel,
                                           dataReady: true,
                                           makeDataReadyCallback: nil,
                                           refcon: nil,
                                           formatDescription: format!,
                                           sampleTiming: &timing,
                                           sampleBufferOut: &sample)
        let output = sample?.toPixelBuffer()
        XCTAssertEqual(output, pixel)
    }
    #else
    func testToPixelBuffer() throws {
        throw XCTSkip("AVFoundation not available on this platform")
    }
    #endif
}
