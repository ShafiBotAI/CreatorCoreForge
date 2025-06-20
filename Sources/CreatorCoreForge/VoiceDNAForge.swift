import Foundation

public struct VoiceDNA: Codable {
    public let characterID: String
    public var basePitch: Float
    public var cadence: Float
    public var toneProfile: String
    public var emotionRange: [String: Float]
    public var styleTags: [String]
    public var linkedCharacters: [String]

    public init(characterID: String,
                basePitch: Float,
                cadence: Float,
                toneProfile: String,
                emotionRange: [String: Float],
                styleTags: [String],
                linkedCharacters: [String] = []) {
        self.characterID = characterID
        self.basePitch = basePitch
        self.cadence = cadence
        self.toneProfile = toneProfile
        self.emotionRange = emotionRange
        self.styleTags = styleTags
        self.linkedCharacters = linkedCharacters
    }
}

public final class VoiceDNAForge {
    public static let shared = VoiceDNAForge()

    private var dnaRegistry: [String: VoiceDNA] = [:]
    private let storageKey = "VoiceDNARegistry"

    private init() {
        loadDNARegistry()
    }

    public func createDNA(for characterID: String,
                          basePitch: Float,
                          cadence: Float,
                          toneProfile: String,
                          emotionRange: [String: Float],
                          styleTags: [String]) {
        let dna = VoiceDNA(characterID: characterID,
                           basePitch: basePitch,
                           cadence: cadence,
                           toneProfile: toneProfile,
                           emotionRange: emotionRange,
                           styleTags: styleTags,
                           linkedCharacters: [])
        dnaRegistry[characterID] = dna
        saveDNARegistry()
    }

    public func getDNA(for characterID: String) -> VoiceDNA? {
        dnaRegistry[characterID]
    }

    public func linkCharacters(primaryID: String, linkedID: String) {
        guard var primaryDNA = dnaRegistry[primaryID] else { return }
        if !primaryDNA.linkedCharacters.contains(linkedID) {
            primaryDNA.linkedCharacters.append(linkedID)
            dnaRegistry[primaryID] = primaryDNA
            saveDNARegistry()
        }
    }

    public func updateEmotionProfile(for characterID: String,
                                     emotion: String,
                                     intensity: Float) {
        guard var dna = dnaRegistry[characterID] else { return }
        dna.emotionRange[emotion] = intensity
        dnaRegistry[characterID] = dna
        saveDNARegistry()
    }

    public func resetAllDNA() {
        dnaRegistry.removeAll()
        UserDefaults.standard.removeObject(forKey: storageKey)
    }

    public func exportDNARegistry() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(dnaRegistry),
              let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }
        return jsonString
    }

    // MARK: - Persistence

    private func saveDNARegistry() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(dnaRegistry) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadDNARegistry() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        let decoder = JSONDecoder()
        if let loadedRegistry = try? decoder.decode([String: VoiceDNA].self, from: data) {
            dnaRegistry = loadedRegistry
        }
    }
}
