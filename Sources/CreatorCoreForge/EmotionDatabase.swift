import Foundation

/// Represents a single human emotion with synonyms and a general category.
public struct EmotionRecord: Codable, Equatable {
    public let name: String
    public let synonyms: [String]
    public let category: String

    public init(name: String, synonyms: [String], category: String) {
        self.name = name
        self.synonyms = synonyms
        self.category = category
    }
}

/// In-memory database of common emotions shared across apps.
public final class EmotionDatabase {
    public static let shared = EmotionDatabase()

    /// All emotion records loaded in memory.
    public private(set) var records: [EmotionRecord] = EmotionDatabase.defaultRecords

    public init() {}

    /// Returns the emotion record matching the provided name or synonym.
    public func record(for label: String) -> EmotionRecord? {
        let lowered = label.lowercased()
        return records.first { $0.name.lowercased() == lowered || $0.synonyms.contains(where: { $0.lowercased() == lowered }) }
    }

    /// Default set of human emotions with basic categories.
    private static let defaultRecords: [EmotionRecord] = [
        EmotionRecord(name: "joy", synonyms: ["happiness", "delight", "cheer"], category: "positive"),
        EmotionRecord(name: "sadness", synonyms: ["sorrow", "melancholy", "gloom"], category: "negative"),
        EmotionRecord(name: "anger", synonyms: ["rage", "fury", "irritation"], category: "negative"),
        EmotionRecord(name: "fear", synonyms: ["anxiety", "terror", "dread"], category: "negative"),
        EmotionRecord(name: "surprise", synonyms: ["astonishment", "amazement"], category: "neutral"),
        EmotionRecord(name: "disgust", synonyms: ["revulsion", "contempt"], category: "negative"),
        EmotionRecord(name: "trust", synonyms: ["confidence", "faith"], category: "positive"),
        EmotionRecord(name: "anticipation", synonyms: ["expectation", "hope"], category: "positive"),
        EmotionRecord(name: "love", synonyms: ["affection", "adoration"], category: "positive"),
        EmotionRecord(name: "boredom", synonyms: ["indifference", "apathy"], category: "neutral"),
        EmotionRecord(name: "calm", synonyms: ["peace", "serenity"], category: "positive"),
        EmotionRecord(name: "confusion", synonyms: ["bewilderment", "perplexity"], category: "neutral"),
        EmotionRecord(name: "envy", synonyms: ["jealousy", "resentment"], category: "negative"),
        EmotionRecord(name: "guilt", synonyms: ["remorse", "shame"], category: "negative"),
        EmotionRecord(name: "pride", synonyms: ["self-respect", "ego"], category: "positive"),
        EmotionRecord(name: "relief", synonyms: ["release", "reassurance"], category: "positive"),
        EmotionRecord(name: "nostalgia", synonyms: ["longing", "yearning"], category: "neutral"),
        EmotionRecord(name: "hope", synonyms: ["optimism", "expectancy"], category: "positive"),
        EmotionRecord(name: "shame", synonyms: ["humiliation", "embarrassment"], category: "negative"),
        EmotionRecord(name: "loneliness", synonyms: ["isolation", "solitude"], category: "negative"),
        EmotionRecord(name: "compassion", synonyms: ["empathy", "kindness"], category: "positive"),
        EmotionRecord(name: "frustration", synonyms: ["annoyance", "irritation"], category: "negative"),
        EmotionRecord(name: "gratitude", synonyms: ["thankfulness", "appreciation"], category: "positive"),
        EmotionRecord(name: "admiration", synonyms: ["respect", "esteem"], category: "positive"),
        EmotionRecord(name: "anxiety", synonyms: ["worry", "nervousness"], category: "negative"),
        EmotionRecord(name: "curiosity", synonyms: ["inquisitiveness", "interest"], category: "positive"),
        EmotionRecord(name: "despair", synonyms: ["hopelessness", "desperation"], category: "negative"),
        EmotionRecord(name: "excitement", synonyms: ["thrill", "enthusiasm"], category: "positive"),
        EmotionRecord(name: "sympathy", synonyms: ["pity", "understanding"], category: "positive"),
        EmotionRecord(name: "awe", synonyms: ["wonder", "reverence"], category: "neutral"),
        EmotionRecord(name: "embarrassment", synonyms: ["awkwardness", "mortification"], category: "negative"),
        EmotionRecord(name: "contentment", synonyms: ["satisfaction", "ease"], category: "positive"),
        EmotionRecord(name: "resentment", synonyms: ["bitterness", "grudge"], category: "negative")
    ]
}
