import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Automatically generates and uploads metadata for rendered videos.
public final class MetadataAutoSync {
    private let syncManager: MetadataSyncManager

    public init(syncManager: MetadataSyncManager = MetadataSyncManager()) {
        self.syncManager = syncManager
    }

    /// Generates basic metadata (title, thumbnail placeholder, tags) and uploads it.
    public func generateAndSync(for videoURL: URL,
                                completion: @escaping (Bool) -> Void) {
        var metadata: [String: String] = [:]
        metadata["title"] = videoURL.deletingPathExtension().lastPathComponent
        metadata["thumbnail"] = createThumbnailPlaceholder(for: videoURL)
        metadata["tags"] = generateTags(from: videoURL)
        syncManager.sync(metadata: metadata, for: videoURL.lastPathComponent) { success in
            completion(success)
        }
    }

    private func createThumbnailPlaceholder(for url: URL) -> String {
        // In a real implementation, this would extract a frame from the video.
        // For now we just return a placeholder filename.
        return url.deletingPathExtension().lastPathComponent + "_thumb.png"
    }

    private func generateTags(from url: URL) -> String {
        // Use the filename as naive tags, split by hyphen/underscore.
        let name = url.deletingPathExtension().lastPathComponent
        let parts = name.split(whereSeparator: { $0 == "-" || $0 == "_" })
        return parts.joined(separator: ",")
    }
}
