import Foundation

/// Represents a text segment with optional voice assignment.
public struct Segment {
    public var text: String
    public var character: String?
    public var voice: VoiceProfile?

    public init(text: String, character: String? = nil, voice: VoiceProfile? = nil) {
        self.text = text
        self.character = character
        self.voice = voice
    }
}

/// Utilities for importing books, segmenting chapters, and assigning voices.
public enum BookProcessing {
    /// Import a book from disk using `EbookImporter` and return chapters with
    /// text metadata. `audioURL` will be `nil` until synthesis occurs.
    public static func importBook(filePath: String) -> [Chapter] {
        let importer = EbookImporter()
        let rawChapters = importer.importEbook(from: filePath)
        return rawChapters.enumerated().map { idx, text in
            Chapter(title: "Chapter \(idx + 1)", text: text)
        }
    }

    /// Segment chapters into finer-grained segments using the provided AI engine.
    public static func segmentChapters(_ chapters: [Chapter],
                                       engine: AIEngine = AIEngineFactory.defaultEngine(),
                                       completion: @escaping ([Segment]) -> Void) {
        var results: [Segment] = []
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "segment.queue")
        for chapter in chapters {
            group.enter()
            engine.summarize(chapter.text) { result in
                let summaryText: String
                switch result {
                case .success(let summary):
                    summaryText = summary
                case .failure:
                    summaryText = chapter.text
                }
                queue.sync { results.append(Segment(text: summaryText)) }
                group.leave()
            }
        }
        group.notify(queue: .main) { completion(results) }
    }

    /// Assign voices to each segment using the character map.
    public static func assignVoices(_ segments: [Segment],
                                    characterMap: [String: VoiceProfile]) -> [Segment] {
        return segments.map { segment in
            var seg = segment
            if let char = seg.character, let voice = characterMap[char] {
                seg.voice = voice
            }
            return seg
        }
    }
}
