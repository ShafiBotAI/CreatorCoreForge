#if canImport(Combine)

import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif
import Combine

/// Manages a stack of voice effects applied to spoken utterances.
public final class VoiceFXStackEditor: ObservableObject {
    /// Shared singleton instance.
    public static let shared = VoiceFXStackEditor()

    private var fxStack: [VoiceEffect] = []

    /// Supported voice effects.
    public enum VoiceEffect: String, Codable, CaseIterable {
        case pitchUp
        case pitchDown
        case reverb
        case echo
        case stutter
        case distortion
        case asmr
        case whisper
    }

    #if canImport(AVFoundation)
    /// Applies the currently configured stack to an utterance.
    /// Non-AVFoundation platforms compile out this functionality.
    public func applyStack(to utterance: AVSpeechUtterance) {
        for effect in fxStack {
            switch effect {
            case .pitchUp:
                utterance.pitchMultiplier += 0.2
            case .pitchDown:
                utterance.pitchMultiplier -= 0.2
            case .reverb:
                // Simulated via AVAudioUnitReverb in external playback layer
                break
            case .echo:
                // Simulated via AVAudioUnitDelay
                break
            case .stutter:
                utterance.rate -= 0.1
            case .distortion:
                // Simulated via AVAudioUnitDistortion
                break
            case .asmr:
                utterance.volume = 0.4
                utterance.rate -= 0.2
            case .whisper:
                utterance.volume = 0.3
                utterance.pitchMultiplier += 0.1
            }
        }
    }
    #endif

    /// Replaces the current effect stack with a new set of effects.
    public func updateStack(_ newStack: [VoiceEffect]) {
        fxStack = newStack
    }

    /// Returns the current effect stack.
    public func getCurrentStack() -> [VoiceEffect] {
        return fxStack
    }

    /// Removes all effects from the stack.
    public func clearStack() {
        fxStack.removeAll()
    }
}

#else

import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Fallback implementation when Combine is unavailable.
public final class VoiceFXStackEditor {
    public static let shared = VoiceFXStackEditor()

    private var fxStack: [VoiceEffect] = []

    public enum VoiceEffect: String, Codable, CaseIterable {
        case pitchUp
        case pitchDown
        case reverb
        case echo
        case stutter
        case distortion
        case asmr
        case whisper
    }

#if canImport(AVFoundation)
    public func applyStack(to utterance: AVSpeechUtterance) {
        for effect in fxStack {
            switch effect {
            case .pitchUp:
                utterance.pitchMultiplier += 0.2
            case .pitchDown:
                utterance.pitchMultiplier -= 0.2
            case .reverb:
                break
            case .echo:
                break
            case .stutter:
                utterance.rate -= 0.1
            case .distortion:
                break
            case .asmr:
                utterance.volume = 0.4
                utterance.rate -= 0.2
            case .whisper:
                utterance.volume = 0.3
                utterance.pitchMultiplier += 0.1
            }
        }
    }
#endif

    public func updateStack(_ newStack: [VoiceEffect]) {
        fxStack = newStack
    }

    public func getCurrentStack() -> [VoiceEffect] {
        return fxStack
    }

    public func clearStack() {
        fxStack.removeAll()
    }
}

#endif

