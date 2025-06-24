import Foundation

/// Provides advanced utilities for visual project management.
public struct VisualFeatureEnhancer {
    public init() {}
    
    /// Shift a timeline by the provided offset (seconds).
    public func shiftTimeline(_ timeline: [Double], by offset: Double) -> [Double] {
        timeline.map { $0 + offset }
    }
    
    /// Return the tone timeline for a character.
    public func syncVisualMemory(character: String, profiles: CharacterProfileManager) -> [ToneRecord] {
        profiles.profile(for: character)?.toneTimeline ?? []
    }
    
    private var fxHistory: [String: [String]] = [:]
    
    /// Record a visual effect used in a scene.
    public mutating func recordFX(sceneID: String, fx: String) {
        fxHistory[sceneID, default: []].append(fx)
    }
    
    /// Fetch previously used FX for a scene.
    public func fxHistory(for sceneID: String) -> [String] {
        fxHistory[sceneID] ?? []
    }
    
    private var locationModels: [String: String] = [:]
    
    /// Register a reusable location model.
    public mutating func registerLocation(_ location: String, model: String) {
        locationModels[location] = model
    }
    
    /// Look up a stored location model.
    public func model(for location: String) -> String? {
        locationModels[location]
    }
    
    /// Recommend filters previously used for a book/project.
    public func recommendFilters(for project: String) -> [String] {
        fxHistory[project] ?? []
    }
    
    private var seriesThemes: [String: String] = [:]
    
    /// Tag a series with a visual theme.
    public mutating func setTheme(_ theme: String, for series: String) {
        seriesThemes[series] = theme
    }
    
    /// Retrieve the theme for a series.
    public func theme(for series: String) -> String? {
        seriesThemes[series]
    }
    
    /// Return the number of tracked projects (for dashboards).
    public func projectCount() -> Int {
        Set(locationModels.keys.map { $0.split(separator: "|").first ?? "" }).count
    }
    
    /// Retrieve a character's visual arc timeline based on tone records.
    public func arcTimeline(character: String, profiles: CharacterProfileManager) -> [ToneRecord] {
        profiles.profile(for: character)?.toneTimeline ?? []
    }
    
    /// Simple framing style suggestion based on memory weight.
    public func frameStyle(for weight: Double) -> String {
        weight > 0.5 ? "vivid" : "faded"
    }
    
    /// Cross-reference scene files with an audio timeline.
    public func crossReference(sceneFiles: [String], audioTimeline: [String]) -> [String] {
        sceneFiles.filter { audioTimeline.contains($0) }
    }
    
    /// Detect visual inconsistencies between two descriptors.
    public func hasVisualInconsistency(current: String, previous: String) -> Bool {
        current != previous
    }
    
    /// Recommend background reuse counts from a list of locations.
    public func recommendBackgroundReuse(locations: [String]) -> [String: Int] {
        var counts: [String: Int] = [:]
        for loc in locations { counts[loc, default: 0] += 1 }
        return counts.filter { $0.value > 1 }
    }
    
    /// Generate a recap montage string from stored frames.
    public func generateRecap(from frames: [String]) -> String {
        frames.joined(separator: "|")
    }
    
    /// Integrate multiple memory graphs by summing edge weights.
    public func integrateMemoryGraphs(graphs: [[String: Int]]) -> [String: Int] {
        graphs.reduce(into: [:]) { result, graph in
            for (k, v) in graph { result[k, default: 0] += v }
        }
    }
    
    /// Detect recurring visual cues across books.
    public func recurringCues(in visuals: [String]) -> [String: Int] {
        visuals.reduce(into: [:]) { $0[$1, default: 0] += 1 }.filter { $0.value > 1 }
    }
    
    /// Export visual memory for team handoff.
    public func exportVisualMemory() -> Data? {
        try? JSONSerialization.data(withJSONObject: fxHistory, options: [])
    }
    
    /// Import visual memory data.
    public mutating func importVisualMemory(_ data: Data) {
        if let map = try? JSONSerialization.jsonObject(with: data) as? [String: [String]] {
            for (k, v) in map { fxHistory[k] = v }
        }
    }
    
    /// Produce a multiverse map via the manager.
    public func multiverseMap(manager: VisualMultiverseManager, project: String) -> [String: Int] {
        manager.multiverseMap(for: project)
    }
    
    /// Retrieve timeline variants for side-by-side preview.
    public func previewOutcomes(manager: VisualMultiverseManager, sceneID: String, project: String) -> [VisualOutcome] {
        manager.timelineVariants(for: sceneID, project: project)
    }
}
