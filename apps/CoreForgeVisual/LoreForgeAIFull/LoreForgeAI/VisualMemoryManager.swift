import Foundation

public struct CharacterVisualState: Codable, Equatable {
    public var hairstyle: String
    public var outfit: String
    public var mood: String
    public init(hairstyle: String, outfit: String, mood: String) {
        self.hairstyle = hairstyle
        self.outfit = outfit
        self.mood = mood
    }
}

public struct SceneKey: Codable, Hashable {
    public var book: String
    public var index: Int
    public init(book: String, index: Int) {
        self.book = book
        self.index = index
    }
}

public struct VisualMemorySnapshot: Codable {
    public let timelineShift: [String: Int]
    public let characterVoiceTone: [String: String]
    public let fxHistory: [SceneKey: [String]]
    public let locationModels: [String: String]
    public let seriesThemes: [String]
    public let characterArcs: [String: [Int: CharacterVisualState]]
    public let narratorVoice: String?
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
    public private(set) var enabledDashboards: Set<String> = []
    public private(set) var sceneAudioMap: [SceneKey: Double] = [:]
    private var callbacks: [SceneKey: SceneKey] = [:]
    public private(set) var memoryGraph: [SceneKey: [SceneKey]] = [:]
    public private(set) var memoryGraphIntegrated = false
    public private(set) var handoffHistory: [String] = []
    public private(set) var narratorVoice: String?

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
        for b in books { enabledDashboards.insert(b) }
        return Array(enabledDashboards)
    }

    /// Record a character's visual state at a scene index.
    public func recordVisualArc(character: String, scene: Int, state: CharacterVisualState) {
        characterArcs[character, default: [:]][scene] = state
    }

    /// Set the voice used for narration segments.
    public func setNarratorVoice(_ voice: String) {
        narratorVoice = voice
    }

    /// Retrieve the currently selected narrator voice.
    public func getNarratorVoice() -> String? { narratorVoice }

    /// Suggest framing technique based on memory weight.
    public func adaptFraming(weight: Double) -> String {
        return weight > 0.5 ? "close" : "wide"
    }

    /// Cross reference a scene with the audio timeline.
    /// Returns true if the value was recorded or updated.
    public func crossReference(scene: SceneKey, audioStart: Double) -> Bool {
        guard audioStart >= 0 else { return false }
        if let existing = sceneAudioMap[scene] {
            if abs(existing - audioStart) <= 0.1 { return false }
        }
        sceneAudioMap[scene] = audioStart
        return true
    }

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

    /// Record a callback relationship between scenes.
    public func recordCallback(from: SceneKey, to: SceneKey) {
        callbacks[from] = to
    }

    /// Retrieve a callback scene for highlighting.
    public func highlightCallback(scene: SceneKey) -> SceneKey {
        callbacks[scene] ?? SceneKey(book: scene.book, index: max(scene.index - 1, 0))
    }

    /// Generate a simple recap montage from the provided scenes.
    public func generateRecapMontage(for scenes: [SceneKey]) -> [SceneKey] {
        guard !scenes.isEmpty else { return [] }
        if scenes.count <= 3 { return scenes }
        let mid = scenes.count / 2
        return [scenes.first!, scenes[mid], scenes.last!]
    }

    /// Build a simple memory graph of scene relationships.
    public func integrateMemoryGraph() {
        memoryGraph = [:]
        for (char, arc) in characterArcs {
            let sorted = arc.keys.sorted()
            for i in 0..<(sorted.count - 1) {
                let from = SceneKey(book: char, index: sorted[i])
                let to = SceneKey(book: char, index: sorted[i + 1])
                memoryGraph[from, default: []].append(to)
            }
        }
        for (from, forks) in sceneForks {
            for (_, to) in forks {
                memoryGraph[from, default: []].append(to)
            }
        }
        memoryGraphIntegrated = true
    }

    /// Detect recurring visual cues using basic frequency counts.
    public func detectRecurringVisualCues(in scenes: [SceneKey]) -> [SceneKey] {
        var freq: [String: Int] = [:]
        for key in scenes {
            for fx in fxHistory[key] ?? [] {
                freq[fx, default: 0] += 1
            }
        }
        let recurring = Set(freq.filter { $0.value > 1 }.map { $0.key })
        return scenes.filter { key in
            (fxHistory[key]?.contains { recurring.contains($0) }) ?? false
        }
    }

    /// Export a snapshot of current memory for account transfer.
    @discardableResult
    public func handoffMemory(to account: String) -> URL? {
        let snapshot = VisualMemorySnapshot(
            timelineShift: timelineShift,
            characterVoiceTone: characterVoiceTone,
            fxHistory: fxHistory,
            locationModels: locationModels,
            seriesThemes: Array(seriesThemes),
            characterArcs: characterArcs,
            narratorVoice: narratorVoice)
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("memory-\(account).json")
        do {
            let data = try JSONEncoder().encode(snapshot)
            try data.write(to: url)
            handoffHistory.append(account)
            return url
        } catch {
            return nil // failed to save snapshot
        }
    }

    /// Create a scene fork with a tag.
    public func createSceneFork(original: SceneKey, tag: String) -> SceneKey {
        let fork = SceneKey(book: original.book, index: original.index)
        sceneForks[original, default: [:]][tag] = fork
        memoryGraph[original, default: []].append(fork)
        return fork
    }

    /// Store an alternate outcome for a scene.
    public func storeAlternateOutcome(for key: SceneKey, outcomeTag: String) {
        sceneForks[key, default: [:]][outcomeTag] = key
        memoryGraph[key, default: []].append(key)
    }
}

