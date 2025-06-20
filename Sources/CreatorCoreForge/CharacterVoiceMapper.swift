import Foundation

/// Maps character names found in book text to unique voice names.
public struct CharacterVoiceMap {
    public var name: String
    public var assignedVoice: String
}

/// Simple engine that assigns voices to characters using a round-robin list.
public final class CharacterVoiceMapper {
    private var knownCharacters: [String: String] = [:]
    private let availableVoices = [
        "Aria", "Eli", "Nova", "Kai", "Luna",
        "Zane", "Mira", "Orion", "Sage", "Rhea"
    ]
    private var voiceIndex = 0

    public init() {}

    /// Parse book text and assign voices to any detected speaker names.
    /// Speaker lines are expected in the form `Name: Dialogue`.
    public func assignVoices(to ebookText: String) -> [CharacterVoiceMap] {
        let lines = ebookText.components(separatedBy: "\n")
        var nameSet = Set<String>()
        for line in lines {
            if line.contains(":") {
                let components = line.components(separatedBy: ":")
                let name = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                if !name.isEmpty {
                    nameSet.insert(name)
                }
            }
        }

        var results: [CharacterVoiceMap] = []
        for name in nameSet.sorted() {
            let voice = getNextVoice()
            knownCharacters[name] = voice
            results.append(CharacterVoiceMap(name: name, assignedVoice: voice))
        }
        return results
    }

    private func getNextVoice() -> String {
        let voice = availableVoices[voiceIndex % availableVoices.count]
        voiceIndex += 1
        return voice
    }

    /// Retrieve the voice previously assigned to a character, if any.
    public func getVoice(for character: String) -> String? {
        knownCharacters[character]
    }

    /// Print all current voice assignments to stdout.
    public func printVoiceAssignments() {
        for (name, voice) in knownCharacters {
            print("\(name): \(voice)")
        }
    }
}
