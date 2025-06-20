// NSFWHabitBehaviorSimulator.swift
// CoreForge Audio – Phase 7 Module

import Foundation
#if canImport(Combine)
import Combine

/// Simulator for character-specific NSFW behavior habits triggered by key phrases.
public final class NSFWHabitBehaviorSimulator: ObservableObject {
    public static let shared = NSFWHabitBehaviorSimulator()

    public struct HabitCue: Identifiable, Codable {
        public var id: UUID = UUID()
        public var characterName: String
        public var behaviorDescription: String
        public var triggerWords: [String]
        public var responseSoundFile: String
        public var frequency: Float // Probability (0.0 to 1.0) of triggering
    }

    @Published public var habits: [HabitCue] = []

    /// Register a new NSFW habit for a character.
    public func registerHabit(for character: String,
                               behavior: String,
                               triggerWords: [String],
                               responseSoundFile: String,
                               frequency: Float = 0.5) {
        let cue = HabitCue(characterName: character,
                            behaviorDescription: behavior,
                            triggerWords: triggerWords,
                            responseSoundFile: responseSoundFile,
                            frequency: frequency)
        habits.append(cue)
    }

    /// Simulate a line of dialogue and return a sound file if a habit triggers.
    public func simulate(for line: String, character: String) -> String? {
        for cue in habits where cue.characterName.lowercased() == character.lowercased() {
            for trigger in cue.triggerWords {
                if line.lowercased().contains(trigger.lowercased()) &&
                    Float.random(in: 0...1) < cue.frequency {
                    return cue.responseSoundFile
                }
            }
        }
        return nil
    }

    /// Remove registered habits for a specific character, or all habits if nil.
    public func clearHabits(for character: String? = nil) {
        if let name = character {
            habits.removeAll { $0.characterName == name }
        } else {
            habits.removeAll()
        }
    }
}
#else

public final class NSFWHabitBehaviorSimulator {
    public static let shared = NSFWHabitBehaviorSimulator()

    public struct HabitCue: Identifiable, Codable {
        public var id: UUID = UUID()
        public var characterName: String
        public var behaviorDescription: String
        public var triggerWords: [String]
        public var responseSoundFile: String
        public var frequency: Float
    }

    public var habits: [HabitCue] = []

    public func registerHabit(for character: String,
                               behavior: String,
                               triggerWords: [String],
                               responseSoundFile: String,
                               frequency: Float = 0.5) {
        let cue = HabitCue(characterName: character,
                            behaviorDescription: behavior,
                            triggerWords: triggerWords,
                            responseSoundFile: responseSoundFile,
                            frequency: frequency)
        habits.append(cue)
    }

    public func simulate(for line: String, character: String) -> String? {
        for cue in habits where cue.characterName.lowercased() == character.lowercased() {
            for trigger in cue.triggerWords {
                if line.lowercased().contains(trigger.lowercased()) &&
                    Float.random(in: 0...1) < cue.frequency {
                    return cue.responseSoundFile
                }
            }
        }
        return nil
    }

    public func clearHabits(for character: String? = nil) {
        if let name = character {
            habits.removeAll { $0.characterName == name }
        } else {
            habits.removeAll()
        }
    }
}
#endif

// Example usage:
// NSFWHabitBehaviorSimulator.shared.registerHabit(for: "Kai",
//     behavior: "groans when aroused",
//     triggerWords: ["kiss", "touch"],
//     responseSoundFile: "groan1.wav",
//     frequency: 0.7)
