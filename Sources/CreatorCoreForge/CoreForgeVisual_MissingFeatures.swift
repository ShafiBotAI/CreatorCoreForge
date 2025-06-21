import Foundation

/// Utilities bridging missing CoreForge Visual features.
public struct CoreForgeVisualFeatures {
    public init() {}

    /// Verify age and optional ID then enable NSFW access using a PIN.
    /// Returns true on success.
    @discardableResult
    public func verifyAgeAndEnableNSFW(birthdate: Date, pin: String) -> Bool {
        guard DOBCheck.isOfAge(birthdate: birthdate) else { return false }
        return CommunityFilter.shared.enableNSFW(pin: pin)
    }

    /// Verify age and ID then enable NSFW access using a PIN.
    @discardableResult
    public func verifyAgeIDAndEnableNSFW(birthdate: Date, idNumber: String, pin: String) -> Bool {
        let verifier = AgeIDVerifier()
        guard verifier.verify(birthdate: birthdate, idNumber: idNumber) else { return false }
        return CommunityFilter.shared.enableNSFW(pin: pin)
    }

    /// Generate a very small video file that shows each scene's text as a frame.
    /// When AVFoundation is unavailable a simple text file with the `.mp4`
    /// extension is produced so callers can still handle a URL.
    public func generateSceneVideo(from text: String) -> URL {
        let scenes = SceneGenerator().generateScenes(from: text)
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("mp4")
#if canImport(AVFoundation)
        let writer = try? AVAssetWriter(url: url, fileType: .mp4)
        let settings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: 640,
            AVVideoHeightKey: 480
        ]
        if let writer = writer {
            let input = AVAssetWriterInput(mediaType: .video, outputSettings: settings)
            let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input,
                                                               sourcePixelBufferAttributes: nil)
            writer.add(input)
            writer.startWriting()
            writer.startSession(atSourceTime: .zero)
            let font = CTFontCreateWithName("Helvetica" as CFString, 24, nil)
            for (index, scene) in scenes.enumerated() {
                while !input.isReadyForMoreMediaData { Thread.sleep(forTimeInterval: 0.05) }
                if let buffer = Self.makePixelBuffer(text: scene, font: font) {
                    let time = CMTime(seconds: Double(index), preferredTimescale: 600)
                    adaptor.append(buffer, withPresentationTime: time)
                }
            }
            input.markAsFinished()
            writer.finishWriting {}
        } else {
            try? scenes.joined(separator: "\n").write(to: url, atomically: true, encoding: .utf8)
        }
#else
        let contents = scenes.joined(separator: "\n")
        try? contents.data(using: .utf8)?.write(to: url)
#endif
        return url
    }

    /// Copy the given video and tag it with the desired render style.
    public func renderWithStyle(_ url: URL, style: String) -> URL {
        let out = url.deletingLastPathComponent()
            .appendingPathComponent(style + "_" + url.lastPathComponent)
        try? FileManager.default.copyItem(at: url, to: out)
        return out
    }

    /// Upload a rendered video to the desired platform. This demo implementation
    /// simply returns a confirmation string.
    public func uploadToPlatform(_ url: URL, platform: String) -> String {
        "Uploaded \(url.lastPathComponent) to \(platform)"
    }

    #if canImport(AVFoundation)
    private static func makePixelBuffer(text: String, font: CTFont) -> CVPixelBuffer? {
        let attrs: [CFString: Any] = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true
        ]
        var buffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, 640, 480,
                                         kCVPixelFormatType_32ARGB, attrs as CFDictionary, &buffer)
        guard status == kCVReturnSuccess, let pxBuffer = buffer else { return nil }
        CVPixelBufferLockBaseAddress(pxBuffer, [])
        if let ctx = CGContext(data: CVPixelBufferGetBaseAddress(pxBuffer),
                               width: 640,
                               height: 480,
                               bitsPerComponent: 8,
                               bytesPerRow: CVPixelBufferGetBytesPerRow(pxBuffer),
                               space: CGColorSpaceCreateDeviceRGB(),
                               bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) {
            ctx.setFillColor(NSColor.black.cgColor)
            ctx.fill(CGRect(x: 0, y: 0, width: 640, height: 480))
            let attr = [NSAttributedString.Key.font: font,
                        NSAttributedString.Key.foregroundColor: NSColor.white]
            let attributed = NSAttributedString(string: text, attributes: attr)
            let line = CTLineCreateWithAttributedString(attributed)
            ctx.textPosition = CGPoint(x: 20, y: 220)
            CTLineDraw(line, ctx)
        }
        CVPixelBufferUnlockBaseAddress(pxBuffer, [])
        return buffer
    }
    #endif
}
