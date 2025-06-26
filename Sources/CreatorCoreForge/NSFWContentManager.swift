// NSFWContentManager.swift
// CoreForge Audio – Phase 7 Module

import Foundation

#if canImport(Combine)
import Combine

public final class NSFWContentManager: ObservableObject {
    public static let shared = NSFWContentManager()

    private let consentTracker = ConsentTracker.shared
    private var aftercareIndex = 0
    public var aftercarePrompts: [String] = [
        "Take a moment to breathe and hydrate.",
        "Remember to respect boundaries and communicate.",
        "Consider a gentle cool-down or aftercare routine."
    ]

    @Published public var unlocked: Bool = false
    @Published public var ageVerified: Bool = false
    @Published public var nsfwSceneLog: [NSFWScene] = []
    @Published public var contentIntensity: NSFWIntensity = .softcore
    @Published public var contentMode: NSFWContentMode = .slow
    @Published public var viewerFilterEnabled: Bool = false

    public enum NSFWIntensity: String, Codable, CaseIterable {
        case off, softcore, sensual, rough, hardcore
    }

    public enum NSFWContentMode: String, Codable, CaseIterable {
        case slow, medium, extreme
    }

    public struct NSFWScene: Identifiable, Codable {
        public var id: UUID = UUID()
        public var chapter: String
        public var sceneLabel: String
        public var intensity: NSFWIntensity
        public var timestamp: Date
    }

    public func unlock(with promoCode: String) {
        guard ageVerified else { return }
        if promoCode.lowercased() == "creatoraccess" {
            unlocked = true
            consentTracker.logConsent(userID: "local", consent: true)
        }
    }

    /// Verify user age for NSFW access.
    public func verifyAge(_ age: Int) {
        ageVerified = age >= ContentPolicyManager.ageLimit
    }

    public func logConsent(userID: String, consent: Bool) {
        consentTracker.logConsent(userID: userID, consent: consent)
    }

    public func shouldPause(for text: String) -> Bool {
        consentTracker.containsSafeWord(text)
    }

    public func nextAftercarePrompt() -> String {
        guard !aftercarePrompts.isEmpty else { return "" }
        let prompt = aftercarePrompts[aftercareIndex % aftercarePrompts.count]
        aftercareIndex += 1
        return prompt
    }

    public func logScene(chapter: String, label: String, intensity: NSFWIntensity) {
        let entry = NSFWScene(chapter: chapter, sceneLabel: label, intensity: intensity, timestamp: Date())
        nsfwSceneLog.append(entry)
        let dbEntry = NSFWEntry(label: label,
                                type: .text,
                                tags: [chapter],
                                timestamp: entry.timestamp,
                                filePath: nil,
                                notes: "Logged from NSFWContentManager")
        NSFWDatabase.shared.add(dbEntry)
    }

    public func getRecentScenes(limit: Int = 10) -> [NSFWScene] {
        return nsfwSceneLog.suffix(limit).reversed()
    }

    public func filterScenes(by intensity: NSFWIntensity) -> [NSFWScene] {
        return nsfwSceneLog.filter { $0.intensity == intensity }
    }

    public func clearSceneLog() {
        nsfwSceneLog.removeAll()
    }

    public func setIntensity(level: NSFWIntensity) {
        self.contentIntensity = level
    }

    public func setMode(_ mode: NSFWContentMode) {
        self.contentMode = mode
    }

    public func setViewerFilter(enabled: Bool) {
        viewerFilterEnabled = enabled
    }

    public func isSceneAllowed(_ intensity: NSFWIntensity) -> Bool {
        guard unlocked else { return false }
        if viewerFilterEnabled && intensity != .off {
            return false
        }
        let levels = NSFWIntensity.allCases
        guard let currentIndex = levels.firstIndex(of: contentIntensity),
              let sceneIndex = levels.firstIndex(of: intensity) else {
            return false
        }
        return sceneIndex <= currentIndex
    }
}
#else

public final class NSFWContentManager {
    public static let shared = NSFWContentManager()

    private let consentTracker = ConsentTracker.shared
    private var aftercareIndex = 0
    public var aftercarePrompts: [String] = [
        "Take a moment to breathe and hydrate.",
        "Remember to respect boundaries and communicate.",
        "Consider a gentle cool-down or aftercare routine."
    ]

    public var unlocked: Bool = false
    public var ageVerified: Bool = false
    public var nsfwSceneLog: [NSFWScene] = []
    public var contentIntensity: NSFWIntensity = .softcore
    public var contentMode: NSFWContentMode = .slow
    public var viewerFilterEnabled: Bool = false

    public enum NSFWIntensity: String, Codable, CaseIterable {
        case off, softcore, sensual, rough, hardcore
    }

    public enum NSFWContentMode: String, Codable, CaseIterable {
        case slow, medium, extreme
    }

    public struct NSFWScene: Identifiable, Codable {
        public var id: UUID = UUID()
        public var chapter: String
        public var sceneLabel: String
        public var intensity: NSFWIntensity
        public var timestamp: Date
    }

    public func unlock(with promoCode: String) {
        guard ageVerified else { return }
        if promoCode.lowercased() == "creatoraccess" {
            unlocked = true
            consentTracker.logConsent(userID: "local", consent: true)
        }
    }

    /// Verify user age for NSFW access.
    public func verifyAge(_ age: Int) {
        ageVerified = age >= ContentPolicyManager.ageLimit
    }

    public func logConsent(userID: String, consent: Bool) {
        consentTracker.logConsent(userID: userID, consent: consent)
    }

    public func shouldPause(for text: String) -> Bool {
        consentTracker.containsSafeWord(text)
    }

    public func nextAftercarePrompt() -> String {
        guard !aftercarePrompts.isEmpty else { return "" }
        let prompt = aftercarePrompts[aftercareIndex % aftercarePrompts.count]
        aftercareIndex += 1
        return prompt
    }

    public func logScene(chapter: String, label: String, intensity: NSFWIntensity) {
        let entry = NSFWScene(chapter: chapter, sceneLabel: label, intensity: intensity, timestamp: Date())
        nsfwSceneLog.append(entry)
        let dbEntry = NSFWEntry(label: label,
                                type: .text,
                                tags: [chapter],
                                timestamp: entry.timestamp,
                                filePath: nil,
                                notes: "Logged from NSFWContentManager")
        NSFWDatabase.shared.add(dbEntry)
    }

    public func getRecentScenes(limit: Int = 10) -> [NSFWScene] {
        return nsfwSceneLog.suffix(limit).reversed()
    }

    public func filterScenes(by intensity: NSFWIntensity) -> [NSFWScene] {
        return nsfwSceneLog.filter { $0.intensity == intensity }
    }

    public func clearSceneLog() {
        nsfwSceneLog.removeAll()
    }

    public func setIntensity(level: NSFWIntensity) {
        self.contentIntensity = level
    }

    public func setMode(_ mode: NSFWContentMode) {
        self.contentMode = mode
    }

    public func setViewerFilter(enabled: Bool) {
        viewerFilterEnabled = enabled
    }

    public func isSceneAllowed(_ intensity: NSFWIntensity) -> Bool {
        guard unlocked else { return false }
        if viewerFilterEnabled && intensity != .off {
            return false
        }
        let levels = NSFWIntensity.allCases
        guard let currentIndex = levels.firstIndex(of: contentIntensity),
              let sceneIndex = levels.firstIndex(of: intensity) else {
            return false
        }
        return sceneIndex <= currentIndex
    }
}
#endif

// Usage: unlock(with: "creatoraccess"),
//        setIntensity(level: .hardcore),
//        setMode(.extreme),
//        isSceneAllowed(.rough)
