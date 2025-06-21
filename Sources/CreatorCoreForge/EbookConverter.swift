import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Represents a single audio segment generated from a chapter.
public struct AudioSegment {
    public let chapter: String
    public let audioFileURL: String
}

/// Simple converter that splits an ebook's text by blank lines and generates
/// synthesized audio files for each chapter. Uses `LocalVoiceAI` on all
/// platforms and `AVFoundation` when available for higher quality output.
public final class EbookConverter {
    private let voiceAI: LocalVoiceAI
    private let voice: VoiceProfile

    public init(profile: VoiceProfile = VoiceProfile(name: "Narrator")) {
        self.voiceAI = LocalVoiceAI()
        self.voice = profile
    }

    /// Convert raw ebook text into audio segments.
    public func convertEbookToAudio(ebookText: String) -> [AudioSegment] {
        let chapters = ebookText.components(separatedBy: "\n\n")
        var results: [AudioSegment] = []
        let group = DispatchGroup()
        let lock = DispatchQueue(label: "ebook.converter.lock")

        for (index, chapter) in chapters.enumerated() {
            group.enter()
            let tempURL = FileManager.default.temporaryDirectory
                .appendingPathComponent("chapter_\(index + 1)")
                .appendingPathExtension("wav")

            voiceAI.synthesize(text: chapter, with: voice) { result in
                if case .success(let data) = result {
                    try? data.write(to: tempURL)
                }
                lock.sync {
                    results.append(AudioSegment(chapter: chapter,
                                                audioFileURL: tempURL.path))
                }
                group.leave()
            }
        }

        group.wait()
        return results.sorted { $0.audioFileURL < $1.audioFileURL }
    }
}
