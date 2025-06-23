import Foundation
#if canImport(Vision)
import Vision
import CoreGraphics
#endif

/// Simple OCR scanner that attempts to recognize text from image data.
/// Falls back to UTF-8 decoding when the Vision framework is unavailable.
public final class OCRScanMode {
    public init() {}

    public func extractText(from data: Data) -> String {
#if canImport(Vision)
        if let provider = CGDataProvider(data: data as CFData),
           let image = CGImage(jpegDataProviderSource: provider,
                               decode: nil,
                               shouldInterpolate: true,
                               intent: .defaultIntent) ??
                        CGImage(pngDataProviderSource: provider,
                                decode: nil,
                                shouldInterpolate: true,
                                intent: .defaultIntent) {
            let request = VNRecognizeTextRequest()
            let handler = VNImageRequestHandler(cgImage: image, options: [:])
            try? handler.perform([request])
            let texts = request.results?.compactMap { $0.topCandidates(1).first?.string }
            if let joined = texts?.joined(separator: " "), !joined.isEmpty {
                return joined
            }
        }
#endif
        return String(data: data, encoding: .utf8) ?? ""
    }
}
