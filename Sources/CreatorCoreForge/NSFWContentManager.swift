// NSFWContentManager.swift
// CoreForge Audio – Phase 7 Module

import Foundation

#if canImport(Combine)
import Combine

public final class NSFWContentManager: ObservableObject {
    public static let shared = NSFWContentManager()

    @Published public var unlocked: Bool = false
    @Published public var nsfwSceneLog: [NSFWScene] = []
    @Published public var contentIntensity: NSFWIntensity = .softcore
    @Published public var contentMode: NSFWContentMode = .slow

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
        if promoCode.lowercased() == "creatoraccess" {
            unlocked = true
        }
    }

    public func logScene(chapter: String, label: String, intensity: NSFWIntensity) {
        let entry = NSFWScene(chapter: chapter, sceneLabel: label, intensity: intensity, timestamp: Date())
        nsfwSceneLog.append(entry)
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

    public func isSceneAllowed(_ intensity: NSFWIntensity) -> Bool {
        guard unlocked else { return false }
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

    public var unlocked: Bool = false
    public var nsfwSceneLog: [NSFWScene] = []
    public var contentIntensity: NSFWIntensity = .softcore
    public var contentMode: NSFWContentMode = .slow

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
        if promoCode.lowercased() == "creatoraccess" {
            unlocked = true
        }
    }

    public func logScene(chapter: String, label: String, intensity: NSFWIntensity) {
        let entry = NSFWScene(chapter: chapter, sceneLabel: label, intensity: intensity, timestamp: Date())
        nsfwSceneLog.append(entry)
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

    public func isSceneAllowed(_ intensity: NSFWIntensity) -> Bool {
        guard unlocked else { return false }
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
