import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Utilities bridging missing CoreForge Audio features for offline mode.
public struct CoreForgeAudioFeatures {
    public init() {}

    /// Create an offline download queue for audio files.
    public func setupOfflineAudioQueue() -> OfflineDownloadQueue {
        OfflineDownloadQueue()
    }

    /// Convert book text into synthesized audio files for each detected chapter.
    public func convertEbookToAudio(text: String,
                                    profile: VoiceProfile,
                                    completion: @escaping ([URL]) -> Void) {
        let chapters = Self.detectChapters(in: text)
        let voiceAI = LocalVoiceAI()
        var urls: [URL] = []
        let group = DispatchGroup()
        let syncQueue = DispatchQueue(label: "audio.urls.queue")
        for (index, chapter) in chapters.enumerated() {
            group.enter()
            voiceAI.synthesize(text: chapter, with: profile) { result in
                if case .success(let data) = result {
                    let url = FileManager.default.temporaryDirectory
                        .appendingPathComponent("chapter\(index).wav")
                    try? data.write(to: url)
                    syncQueue.sync { urls.append(url) }
                }
                group.leave()
            }
        }
        group.notify(queue: .main) { completion(urls) }
    }

    /// Enable stealth mode on the provided vault and optionally set a PIN.
    public func activateStealthVault(_ vault: StealthModeVaultManager, pin: String? = nil) {
        if let pin = pin { vault.setPIN(pin) }
        vault.setStealthMode(true)
    }

    /// Recommend a voice profile based on the text's virality score.
    public func recommendVoiceTone(for text: String) -> VoiceProfile {
        let engine = ViralityEngine()
        if engine.shouldBoost(text: text) {
            return VoiceProfile(name: "Energetic", emotion: "excited")
        }
        return VoiceProfile(name: "Narrator", emotion: "neutral")
    }

    /// Access the shared emotion database for additional emotion context.
    public func emotionInfo(for label: String) -> EmotionRecord? {
        EmotionDatabase.shared.record(for: label)
    }

    /// Merge multiple audio files into a single `.m4b` file.
    /// - Parameters:
    ///   - urls: Array of audio file URLs in playback order.
    ///   - output: Destination URL for the merged file.
    ///   - metadata: Optional metadata to embed (title, artist, etc.).
    ///   - coverArt: Optional image data for the cover art.
    #if canImport(AVFoundation)
    public func mergeAudioFilesToM4B(urls: [URL],
                                     output: URL,
                                     metadata: [String: String]? = nil,
                                     coverArt: Data? = nil,
                                     completion: @escaping (Bool) -> Void) {
        let composition = AVMutableComposition()
        guard !urls.isEmpty else { completion(false); return }

        var insertTime = CMTime.zero
        for url in urls {
            let asset = AVURLAsset(url: url)
            if let track = asset.tracks(withMediaType: .audio).first {
                do {
                    let compTrack = composition.addMutableTrack(withMediaType: .audio,
                                                                  preferredTrackID: kCMPersistentTrackID_Invalid)
                    try compTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration),
                                                   of: track,
                                                   at: insertTime)
                    insertTime = CMTimeAdd(insertTime, asset.duration)
                } catch {
                    completion(false)
                    return
                }
            }
        }

        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4B) else {
            completion(false)
            return
        }
        exporter.outputFileType = .m4b
        exporter.outputURL = output

        if let metadata = metadata {
            exporter.metadata = metadata.map { key, value in
                let item = AVMutableMetadataItem()
                item.key = key as (NSCopying & NSObjectProtocol)?
                item.keySpace = .common
                item.value = value as (NSCopying & NSObjectProtocol)?
                return item
            }
        }

        if let coverData = coverArt {
            let artwork = AVMutableMetadataItem()
            artwork.keySpace = .common
            artwork.key = AVMetadataKey.commonKeyArtwork as (NSCopying & NSObjectProtocol)?
            artwork.value = coverData as (NSCopying & NSObjectProtocol)?
            exporter.metadata = (exporter.metadata ?? []) + [artwork]
        }

        exporter.exportAsynchronously {
            completion(exporter.status == .completed)
        }
    }
    #else
    public func mergeAudioFilesToM4B(urls: [URL],
                                     output: URL,
                                     metadata: [String: String]? = nil,
                                     coverArt: Data? = nil,
                                     completion: @escaping (Bool) -> Void) {
        completion(false)
    }
    #endif

    private static func detectChapters(in text: String) -> [String] {
        let pattern = "(?i)chapter\\s+\\d+"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [text] }
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let matches = regex.matches(in: text, range: range)
        guard !matches.isEmpty else { return [text] }

        var chapters: [String] = []
        var last = text.startIndex
        for match in matches {
            let mRange = Range(match.range, in: text)!
            if mRange.lowerBound > last {
                let chunk = String(text[last..<mRange.lowerBound])
                if !chunk.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    chapters.append(chunk)
                }
            }
            last = mRange.upperBound
        }
        let tail = String(text[last...])
        if !tail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            chapters.append(tail)
        }
        return chapters
    }
}
