import Foundation

/// Represents a collection of sound effect files.
public struct SFXPack: Codable, Hashable {
    public let name: String
    public let files: [String]
    public let isNSFW: Bool
    public init(name: String, files: [String], isNSFW: Bool = false) {
        self.name = name
        self.files = files
        self.isNSFW = isNSFW
    }
}

/// Manages the registration and playback of `SFXPack` objects.
public final class SFXPackManager {
    public static let shared = SFXPackManager()

    private var packs: [String: SFXPack] = [:]

    private init() {
        registerBuiltInPacks()
    }

    /// Register built-in packs for immediate use.
    private func registerBuiltInPacks() {
        let interface = SFXPack(name: "Interface", files: ["ui_click", "swipe", "error_beep"])
        let combat = SFXPack(name: "Combat", files: ["sword_swing", "sword_clash", "explosion_big"])
        let nature = SFXPack(name: "Nature", files: ["forest_day", "water_stream", "fire_crackle"])
        let sciFi = SFXPack(name: "Sci-Fi", files: ["sci_whoosh", "laser_blast", "spaceship_idle"])
        let softMoans = SFXPack(name: "Soft Moans", files: ["moan_soft1", "moan_soft2"], isNSFW: true)
        let heavyBreathing = SFXPack(name: "Heavy Breathing", files: ["breath1", "breath2"], isNSFW: true)
        let asmrTingles = SFXPack(name: "ASMR Tingles", files: ["asmr_tingle1", "asmr_tingle2"], isNSFW: false)
        [interface, combat, nature, sciFi, softMoans, heavyBreathing, asmrTingles].forEach {
            packs[$0.name] = $0
        }
    }

    /// Register a custom pack.
    public func register(pack: SFXPack) {
        packs[pack.name] = pack
    }

    /// Return all available packs filtered by NSFW flag.
    public func availablePacks(includeNSFW: Bool = false) -> [SFXPack] {
        packs.values.filter { includeNSFW || !$0.isNSFW }
    }

    /// Play an entire pack using `SoundEffectManager`.
    public func playPack(named name: String, loop: Bool = false) {
        guard let pack = packs[name] else { return }
        for (index, file) in pack.files.enumerated() {
            let delay = Double(index) * 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
#if canImport(Combine)
                SoundEffectManager.shared.playEffect(named: file, loop: loop)
#else
                // Fall back to ambience playback when the full effect engine is unavailable
                SoundEffectManager.shared.playAmbience(named: file)
#endif
            }
        }
    }
}
