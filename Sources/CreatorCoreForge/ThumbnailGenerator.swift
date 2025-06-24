import Foundation
#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Generates a PNG thumbnail from the first frame of a video.
public struct ThumbnailGenerator {
    public init() {}

    /// Generate a thumbnail image for the given video URL. When AVFoundation
    /// is unavailable, a placeholder text file is produced instead so callers
    /// still receive a valid URL.
    public func generateThumbnail(for videoURL: URL) -> URL {
        let outURL = videoURL.deletingPathExtension().appendingPathExtension("png")
#if canImport(AVFoundation)
        let asset = AVAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        if let cgImage = try? generator.copyCGImage(at: .zero, actualTime: nil) {
#if canImport(UIKit)
            let image = UIImage(cgImage: cgImage)
            if let data = image.pngData() {
                try? data.write(to: outURL)
                return outURL
            }
#elseif canImport(AppKit)
            let image = NSImage(cgImage: cgImage, size: .zero)
            if let tiff = image.tiffRepresentation,
               let rep = NSBitmapImageRep(data: tiff),
               let data = rep.representation(using: .png, properties: [:]) {
                try? data.write(to: outURL)
                return outURL
            }
#endif
        }
#endif
        try? "thumbnail".write(to: outURL, atomically: true, encoding: .utf8)
        return outURL
    }
}
