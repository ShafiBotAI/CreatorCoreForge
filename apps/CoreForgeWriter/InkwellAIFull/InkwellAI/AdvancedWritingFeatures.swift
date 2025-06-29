import Foundation

/// Feature 28: Convert prose paragraphs into speaker-labeled dialogue lines.
struct DialogueLine {
    let speaker: String
    let text: String
}

final class ProseToDialogueConverter {
    func convert(prose: String, defaultSpeaker: String = "Narrator") -> [DialogueLine] {
        let sentences = prose.split(whereSeparator: { ".!?".contains($0) })
        return sentences.enumerated().map { index, sentence in
            let trimmed = sentence.trimmingCharacters(in: .whitespacesAndNewlines)
            let speaker = index % 2 == 0 ? defaultSpeaker : "Character\(index)"
            return DialogueLine(speaker: speaker, text: trimmed)
        }
    }
}

/// Feature 29: Simple interactive interview generator for characters.
final class CharacterInterview {
    func questions(for name: String) -> [String] {
        [
            "What motivates you, \(name)?",
            "Describe your biggest fear, \(name).",
            "How would you react to betrayal?"
        ]
    }
}

/// Feature 30: Detect basic genre or world breaches in a scene text.
final class SceneBreachDetector {
    func detectBreaches(in text: String, allowedKeywords: [String]) -> [String] {
        let lower = text.lowercased()
        return allowedKeywords.filter { !lower.contains($0.lowercased()) }
    }
}

/// Feature 31: Offline sandbox with naive XOR encryption for saves.
final class CreativeSandbox {
    private let key: UInt8 = 0x42

    func encrypt(_ text: String) -> Data {
        let bytes = text.utf8.map { $0 ^ key }
        return Data(bytes)
    }

    func decrypt(_ data: Data) -> String {
        let bytes = data.map { $0 ^ key }
        return String(decoding: bytes, as: UTF8.self)
    }
}

/// Feature 32: Mock publishing simulator.
struct PublishingPreview {
    let title: String
    let blurb: String
    let price: Double
}

final class PublishingSimulator {
    func simulate(title: String, blurb: String) -> PublishingPreview {
        PublishingPreview(title: title, blurb: blurb, price: Double(blurb.count) / 10.0)
    }
}

/// Feature 33: Basic self-publishing export toolkit.
final class SelfPublishingToolkit {
    func export(text: String, format: String) -> Data {
        return Data(text.utf8)
    }
}

/// Feature 34: Convert book content into a simple wiki-style dictionary.
final class FanModeConverter {
    func convertToWiki(chapters: [String]) -> [String: String] {
        var wiki: [String: String] = [:]
        for (index, chapter) in chapters.enumerated() {
            wiki["Chapter_\(index + 1)"] = chapter
        }
        return wiki
    }
}

/// Feature 35: Track repeated time-travel loops.
final class TimeTravelTracker {
    func detectLoops(events: [String]) -> Bool {
        return Set(events).count != events.count
    }
}

/// Feature 36: Generate a surreal dream-like paragraph.
final class DreamGenerator {
    func generate(prompt: String) -> String {
        return "In a dream, \(prompt) melds with clouds and echoes in neon." 
    }
}

/// Feature 37: Produce a simple antagonist arc with redeemability score.
struct AntagonistArc {
    let stages: [String]
    let redeemability: Double
}

final class AntagonistArcGenerator {
    func generateArc(name: String) -> AntagonistArc {
        let stages = ["\(name) appears", "Conflict escalates", "Moment of doubt", "Final showdown"]
        let score = Double(name.count % 10) / 10.0
        return AntagonistArc(stages: stages, redeemability: score)
    }
}
