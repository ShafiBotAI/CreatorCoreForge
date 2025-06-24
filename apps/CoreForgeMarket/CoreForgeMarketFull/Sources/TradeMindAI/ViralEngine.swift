import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Utilities for enhancing video clips with viral-ready tweaks.
public struct ViralEngine {
    public init() {}

#if canImport(AVFoundation)
    /// Loops the given video file the specified number of times.
    /// - Returns: URL of the processed video or the original URL on failure.
    public func loopVideo(at url: URL, count: Int) -> URL {
        guard count > 1 else { return url }
        let asset = AVAsset(url: url)
        let composition = AVMutableComposition()
        guard let track = asset.tracks(withMediaType: .video).first else { return url }
        let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        do {
            for _ in 0..<count {
                try videoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: track, at: composition.duration)
            }
        } catch {
            return url
        }
        if let audio = asset.tracks(withMediaType: .audio).first {
            let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
            do {
                for _ in 0..<count {
                    try audioTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: audio, at: composition.duration)
                }
            } catch {}
        }
        let output = url.deletingLastPathComponent().appendingPathComponent(UUID().uuidString + ".mov")
        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough) else { return url }
        exporter.outputURL = output
        exporter.outputFileType = .mov
        let group = DispatchGroup()
        group.enter()
        exporter.exportAsynchronously { group.leave() }
        group.wait()
        return exporter.status == .completed ? output : url
    }

    /// Adds a text caption overlay to the video.
    /// - Returns: URL of the processed video or the original URL on failure.
    public func addCaption(to url: URL, text: String) -> URL {
        let asset = AVAsset(url: url)
        guard let track = asset.tracks(withMediaType: .video).first else { return url }
        let composition = AVMutableComposition()
        guard let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else { return url }
        do {
            try videoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: track, at: .zero)
        } catch {
            return url
        }
        let videoSize = track.naturalSize
        let parentLayer = CALayer()
        parentLayer.frame = CGRect(origin: .zero, size: videoSize)
        let videoLayer = CALayer()
        videoLayer.frame = parentLayer.frame
        parentLayer.addSublayer(videoLayer)
        let titleLayer = CATextLayer()
        titleLayer.string = text
        titleLayer.alignmentMode = .center
        titleLayer.foregroundColor = CGColor(gray: 1, alpha: 1)
        titleLayer.backgroundColor = CGColor(gray: 0, alpha: 0.5)
        titleLayer.frame = CGRect(x: 0, y: 0, width: videoSize.width, height: 50)
        parentLayer.addSublayer(titleLayer)
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = videoSize
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRange(start: .zero, duration: asset.duration)
        let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        instruction.layerInstructions = [layerInstruction]
        videoComposition.instructions = [instruction]
        videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
        let output = url.deletingLastPathComponent().appendingPathComponent(UUID().uuidString + ".mov")
        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else { return url }
        exporter.outputURL = output
        exporter.outputFileType = .mov
        exporter.videoComposition = videoComposition
        let group = DispatchGroup()
        group.enter()
        exporter.exportAsynchronously { group.leave() }
        group.wait()
        return exporter.status == .completed ? output : url
    }

    /// Applies a quick shock effect to draw attention by flashing brightness.
    /// - Returns: URL of the processed video or the original URL on failure.
    public func applyShockEffect(to url: URL) -> URL {
        let asset = AVAsset(url: url)
        guard let track = asset.tracks(withMediaType: .video).first else { return url }
        let composition = AVMutableComposition()
        guard let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else { return url }
        do {
            try videoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: track, at: .zero)
        } catch {
            return url
        }
        let videoComposition = AVMutableVideoComposition(asset: asset) { request in
            let filter = CIFilter(name: "CIColorControls")!
            filter.setValue(request.sourceImage, forKey: kCIInputImageKey)
            let progress = request.compositionTime.seconds / asset.duration.seconds
            filter.setValue(1 + sin(progress * .pi * 10) * 0.5, forKey: kCIInputBrightnessKey)
            let outputImage = filter.outputImage ?? request.sourceImage
            request.finish(with: outputImage, context: nil)
        }
        videoComposition.renderSize = track.naturalSize
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        let output = url.deletingLastPathComponent().appendingPathComponent(UUID().uuidString + ".mov")
        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else { return url }
        exporter.outputURL = output
        exporter.outputFileType = .mov
        exporter.videoComposition = videoComposition
        let group = DispatchGroup()
        group.enter()
        exporter.exportAsynchronously { group.leave() }
        group.wait()
        return exporter.status == .completed ? output : url
    }
#else
    public func loopVideo(at url: URL, count: Int) -> URL { url }
    public func addCaption(to url: URL, text: String) -> URL { url }
    public func applyShockEffect(to url: URL) -> URL { url }
#endif
}
