import Foundation

public struct CharacterVisualState: Equatable {
    public var hairstyle: String
    public var outfit: String
    public var mood: String
    public init(hairstyle: String, outfit: String, mood: String) {
        self.hairstyle = hairstyle
        self.outfit = outfit
        self.mood = mood
    }
}

public struct SceneKey: Hashable {
    public var book: String
    public var index: Int
    public init(book: String, index: Int) {
        self.book = book
        self.index = index
    }
}

/// Manages visual memory across books and scenes.
public final class VisualMemoryManager {
    public private(set) var timelineShift: [String: Int] = [:]
    public private(set) var characterVoiceTone: [String: String] = [:]
    public private(set) var fxHistory: [SceneKey: [String]] = [:]
    public private(set) var locationModels: [String: String] = [:]
    public private(set) var seriesThemes: Set<String> = []
    public private(set) var characterArcs: [String: [Int: CharacterVisualState]] = [:]
    public private(set) var lockedCharacters: Set<String> = []
    public private(set) var sceneForks: [SceneKey: [String: SceneKey]] = [:]

    public init() {}

    /// Shift timeline indices for a given book (prequels/sequels support).
    public func shiftTimeline(for book: String, by offset: Int) {
        timelineShift[book] = (timelineShift[book] ?? 0) + offset
    }

    /// Sync visual memory with the current voice tone.
    public func sync(character: String, voiceTone: String) {
        characterVoiceTone[character] = voiceTone
    }

    /// Record FX usage for later recall.
    public func storeFX(_ fx: String, for key: SceneKey) {
        fxHistory[key, default: []].append(fx)
    }

    /// Register a reusable location model reference.
    public func reuseLocationModel(_ location: String, model: String) {
        locationModels[location] = model
    }

    /// Suggest filters used previously for a scene.
    public func recommendFilters(for key: SceneKey) -> [String] {
        return fxHistory[key] ?? []
    }

    /// Tag a series-wide visual theme.
    public func tagSeriesTheme(_ theme: String) {
        seriesThemes.insert(theme)
    }

    /// Enable dashboard for multiple books.
    public func enableDashboard(for books: [String]) -> [String] {
        return books
    }

    /// Record a character's visual state at a scene index.
    public func recordVisualArc(character: String, scene: Int, state: CharacterVisualState) {
        characterArcs[character, default: [:]][scene] = state
    }

    /// Suggest framing technique based on memory weight.
    public func adaptFraming(weight: Double) -> String {
        return weight > 0.5 ? "close" : "wide"
    }

    /// Cross reference a scene with the audio timeline (placeholder).
    public func crossReference(scene: SceneKey, audioStart: Double) -> Bool { true }

    /// Compare two visual states for inconsistencies.
    public func checkInconsistency(_ current: CharacterVisualState, _ previous: CharacterVisualState) -> [String] {
        var issues: [String] = []
        if current.hairstyle != previous.hairstyle { issues.append("hairstyle") }
        if current.outfit != previous.outfit { issues.append("outfit") }
        if current.mood != previous.mood { issues.append("mood") }
        return issues
    }

    /// Suggest reusing a background for a location if available.
    public func backgroundReuseSuggestion(for location: String) -> String {
        return locationModels[location] ?? ""
    }

    /// Lock a character's memory to prevent drift.
    public func lockCharacterMemory(_ character: String) {
        lockedCharacters.insert(character)
    }

    /// Placeholder for highlighting callbacks to past scenes.
    public func highlightCallback(scene: SceneKey) -> SceneKey { scene }

    /// Generate a recap montage (placeholder).
    public func generateRecapMontage(for scenes: [SceneKey]) -> [SceneKey] { scenes }

    /// Integrate memory graphs (placeholder).
    public func integrateMemoryGraph() {}

    /// Detect recurring visual cues (placeholder).
    public func detectRecurringVisualCues(in scenes: [SceneKey]) -> [SceneKey] { scenes }

    /// Handoff memory to another account (placeholder).
    public func handoffMemory(to account: String) {}

    /// Create a scene fork with a tag.
    public func createSceneFork(original: SceneKey, tag: String) -> SceneKey {
        let fork = SceneKey(book: original.book, index: original.index)
        sceneForks[original, default: [:]][tag] = fork
        return fork
    }

    /// Store an alternate outcome for a scene.
    public func storeAlternateOutcome(for key: SceneKey, outcomeTag: String) {
        sceneForks[key, default: [:]][outcomeTag] = key
    }
}

