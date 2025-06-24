import Foundation

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
