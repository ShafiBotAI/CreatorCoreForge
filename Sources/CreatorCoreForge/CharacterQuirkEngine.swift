// CharacterQuirkEngine provides small voice cues like sighs or whispers.
#if canImport(Combine)
import Foundation
import Combine
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Plays short vocal quirks for characters during narration.
public final class CharacterQuirkEngine: ObservableObject {
    /// Shared singleton instance.
    public static let shared = CharacterQuirkEngine()

    private init() {}

    private var quirkMap: [String: [QuirkType]] = [:]
    #if canImport(AVFoundation)
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    #else
    private var audioPlayers: [String: Int] = [:]
    #endif

    public enum QuirkType: String, Codable, CaseIterable {
        case sigh, sniff, giggle, cough, whisper, stutter, lipSmack, breathy, grunt, mumble
    }

    /// Assign quirks to a character that will play alongside their lines.
    public func assignQuirks(to character: String, quirks: [QuirkType]) {
        quirkMap[character] = quirks
    }

    /// Trigger all quirks assigned to the given character.
    public func triggerQuirks(for character: String) {
        guard let quirks = quirkMap[character] else { return }
        for quirk in quirks {
            playQuirk(quirk.rawValue)
        }
    }

    /// Stop all currently playing quirks.
    public func stopAllQuirks() {
        #if canImport(AVFoundation)
        for (_, player) in audioPlayers { player.stop() }
        #endif
        audioPlayers.removeAll()
    }

    private func playQuirk(_ name: String) {
        #if canImport(AVFoundation)
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("[CharacterQuirkEngine] Missing quirk sound: \(name).mp3")
            return
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = 0.6
            player.prepareToPlay()
            player.play()
            audioPlayers[name] = player
        } catch {
            print("[CharacterQuirkEngine] Failed to play \(name): \(error.localizedDescription)")
        }
        #endif
    }
}
#else
import Foundation

/// Fallback implementation when Combine is unavailable. This engine
/// keeps a simple in-memory map of character quirks and logs when
/// they are triggered.
public final class CharacterQuirkEngine {
    public static let shared = CharacterQuirkEngine()
    private var quirkMap: [String: [QuirkType]] = [:]

    private init() {}

    public enum QuirkType: String, Codable, CaseIterable {
        case sigh, sniff, giggle, cough, whisper, stutter, lipSmack, breathy, grunt, mumble
    }

    /// Assign quirks to a character.
    public func assignQuirks(to character: String, quirks: [QuirkType]) {
        quirkMap[character] = quirks
    }

    /// Trigger any quirks associated with the character.
    public func triggerQuirks(for character: String) {
        guard let quirks = quirkMap[character] else { return }
        for quirk in quirks {
            print("[Quirk] \(character) performs \(quirk.rawValue)")
        }
    }

    /// Remove all quirks from memory.
    public func stopAllQuirks() {
        quirkMap.removeAll()
    }
}
#endif
