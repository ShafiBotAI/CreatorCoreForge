import Foundation

/// Represents a voice clip with optional NSFW tagging.
public struct VoiceClip {
    public let character: String
    public let text: String
    public let isNSFW: Bool
    public let audioFile: String
}

/// Tracks NSFW voice clips and controls export access.
public final class NSFWManager {
    private var nsfwVault: [VoiceClip] = []
    private var exportEnabled = false

    public init() {}

    /// Tag a voice clip as NSFW if it contains flagged words.
    @discardableResult
    public func tagVoiceClip(character: String, text: String, file: String) -> VoiceClip {
        let lower = text.lowercased()
        let isNSFW = lower.contains("moan") || lower.contains("naked") || lower.contains("touch")
        let clip = VoiceClip(character: character, text: text, isNSFW: isNSFW, audioFile: file)
        if isNSFW {
            nsfwVault.append(clip)
        }
        return clip
    }

    /// List all tagged NSFW voice clips currently in memory.
    public func listNSFWClips() -> [VoiceClip] {
        return nsfwVault
    }

    /// Search vault clips by matching character name or text.
    public func searchClips(keyword: String) -> [VoiceClip] {
        let lower = keyword.lowercased()
        return nsfwVault.filter { clip in
            clip.character.lowercased().contains(lower) ||
                clip.text.lowercased().contains(lower)
        }
    }

    /// Remove all stored NSFW clips.
    public func clearVault() {
        nsfwVault.removeAll()
    }

    /// Enable exporting of NSFW clips when the correct password is provided.
    @discardableResult
    public func enableStealthExport(password: String) -> Bool {
        if password == "stealthmode" {
            exportEnabled = true
            print("\u{1F575}\u{FE0F} Stealth export enabled.")
            return true
        }
        return false
    }

    /// Export the file paths of NSFW clips if stealth export is active.
    public func exportNSFWClips() -> [String] {
        guard exportEnabled else {
            print("\u{1F6AB} Stealth export is disabled.")
            return []
        }
        return nsfwVault.map { $0.audioFile }
    }
}

