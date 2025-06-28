import Foundation

/// Maps character names found in book text to unique voice names.
public struct CharacterVoiceMap {
    public var name: String
    public var assignedVoice: String
}

/// Simple engine that assigns voices to characters using a round-robin list.
public final class CharacterVoiceMapper {
    private var knownCharacters: [String: String] = [:]
    private let availableVoices: [String]
    private var voiceIndex = 0

    /// Create a mapper with an optional custom list of voices.
    public init(voices: [String] = [
        "Aria", "Eli", "Nova", "Kai", "Luna",
        "Zane", "Mira", "Orion", "Sage", "Rhea"
    ]) {
        self.availableVoices = voices
    }

    /// Parse book text and assign voices to any detected speaker names.
    /// Speaker lines may use `:` or `-`/`—` as separators.
    public func assignVoices(to ebookText: String) -> [CharacterVoiceMap] {
        let lines = ebookText.components(separatedBy: "\n")
        var nameSet = Set<String>()
        let separators = [":", " - ", " — "]
        for line in lines {
            for sep in separators {
                if line.contains(sep) {
                    let components = line.components(separatedBy: sep)
                    let name = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    if !name.isEmpty {
                        nameSet.insert(name)
                    }
                    break
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

    /// Assign voices using existing voice memory when available and
    /// automatically store new assignments for future books.
    public func assignVoicesUsingMemory(to ebookText: String,
                                        series: String,
                                        memory: VoiceMemoryManager = .shared) -> [CharacterVoiceMap] {
        let lines = ebookText.components(separatedBy: "\n")
        var nameSet = Set<String>()
        let separators = [":", " - ", " — "]
        for line in lines {
            for sep in separators {
                if line.contains(sep) {
                    let components = line.components(separatedBy: sep)
                    let name = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    if !name.isEmpty { nameSet.insert(name) }
                    break
                }
            }
        }

        var results: [CharacterVoiceMap] = []
        for name in nameSet.sorted() {
            let voice: String
            if let existing = memory.voiceID(for: name, in: series) {
                voice = existing
            } else {
                voice = getNextVoice()
                memory.assign(voiceID: voice, to: name, in: series)
            }
            knownCharacters[name] = voice
            results.append(CharacterVoiceMap(name: name, assignedVoice: voice))
        }
        return results
    }

    /// Assign voices by analyzing how many sentences each character speaks.
    /// Characters with more than 10 sentences will be passed to `manualSelector`
    /// for a custom voice choice. Others receive automatic round-robin voices.
    public func assignVoicesSelective(to ebookText: String,
                                      manualSelector: ((String, [String]) -> String?)? = nil) -> [CharacterVoiceMap] {
        let lines = ebookText.components(separatedBy: "\n")
        let separators = [":", " - ", " — "]
        var counts: [String: Int] = [:]

        for line in lines {
            for sep in separators {
                if line.contains(sep) {
                    let components = line.components(separatedBy: sep)
                    let name = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !name.isEmpty else { break }
                    let utterance = components.dropFirst().joined(separator: sep)
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    let sentenceCount = utterance.split { ".!?".contains($0) }.count
                    counts[name, default: 0] += max(sentenceCount, 1)
                    break
                }
            }
        }

        var results: [CharacterVoiceMap] = []
        for name in counts.keys.sorted() {
            let count = counts[name] ?? 0
            let voice: String
            if count > 10, let chosen = manualSelector?(name, availableVoices) {
                voice = chosen
            } else {
                voice = getNextVoice()
            }
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
