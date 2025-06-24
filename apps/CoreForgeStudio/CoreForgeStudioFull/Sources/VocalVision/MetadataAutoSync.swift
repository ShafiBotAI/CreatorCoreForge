#if canImport(UIKit)
import UIKit
#endif
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
#if canImport(AVFoundation)
import AVFoundation
#endif

#if os(macOS)
extension NSImage {
    var pngData: Data? {
        guard let tiff = tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiff) else { return nil }
        return bitmap.representation(using: .png, properties: [:])
    }
}
#endif

/// Automatically generates and uploads metadata for rendered videos.
public final class MetadataAutoSync {
    private let syncManager: MetadataSyncManager

    public init(syncManager: MetadataSyncManager = MetadataSyncManager()) {
        self.syncManager = syncManager
    }

    /// Generates basic metadata (title, thumbnail image, tags) and uploads it.
    public func generateAndSync(for videoURL: URL,
                                completion: @escaping (Bool) -> Void) {
        var metadata: [String: String] = [:]
        metadata["title"] = videoURL.deletingPathExtension().lastPathComponent
        metadata["thumbnail"] = createThumbnail(for: videoURL)
        metadata["tags"] = generateTags(from: videoURL)
        syncManager.sync(metadata: metadata, for: videoURL.lastPathComponent) { success in
            completion(success)
        }
    }

    private func createThumbnail(for url: URL) -> String {
#if canImport(AVFoundation)
        let asset = AVAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        let outURL = url.deletingPathExtension().appendingPathExtension("png")
        if let cgImage = try? generator.copyCGImage(at: .zero, actualTime: nil) {
#if canImport(UIKit)
            let image = UIImage(cgImage: cgImage)
            if let data = image.pngData() {
                try? data.write(to: outURL)
                return outURL.lastPathComponent
            }
#else
            let image = NSImage(cgImage: cgImage, size: .zero)
            if let data = image.pngData {
                try? data.write(to: outURL)
                return outURL.lastPathComponent
            }
#endif
        }
#endif
        return url.deletingPathExtension().lastPathComponent + "_thumb.png"
    }

    private func generateTags(from url: URL) -> String {
        // Use the filename as naive tags, split by hyphen/underscore.
        let name = url.deletingPathExtension().lastPathComponent
        let parts = name.split(whereSeparator: { $0 == "-" || $0 == "_" })
        return parts.joined(separator: ",")
    }
}
