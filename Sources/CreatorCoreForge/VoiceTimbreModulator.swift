#if canImport(Combine)
import AVFoundation
import Foundation

/// Applies timbre adjustments to AVAudioPCMBuffer instances.
public final class VoiceTimbreModulator: ObservableObject {
    /// Shared singleton instance.
    public static let shared = VoiceTimbreModulator()

    /// Supported timbre profiles.
    public enum TimbreProfile: String, Codable, CaseIterable {
        case warm, sharp, breathy, deep, robotic, whispery, cinematic
    }

    /// Currently active profile.
    @Published public var activeProfile: TimbreProfile = .warm
    /// Intensity of modulation from 0.0 to 1.0.
    @Published public var modulationIntensity: Float = 0.5

    /// Apply the timbre modification and return a new buffer.
    /// - Parameters:
    ///   - audioBuffer: source audio buffer.
    ///   - profile: optional profile override.
    ///   - intensity: optional intensity override.
    /// - Returns: processed buffer (currently just a copy).
    public func applyTimbre(to audioBuffer: AVAudioPCMBuffer,
                            with profile: TimbreProfile? = nil,
                            intensity: Float? = nil) -> AVAudioPCMBuffer {
        let selectedProfile = profile ?? activeProfile
        let selectedIntensity = intensity ?? modulationIntensity

        guard let buffer = AVAudioPCMBuffer(pcmFormat: audioBuffer.format, frameCapacity: audioBuffer.frameCapacity) else {
            return audioBuffer
        }
        buffer.frameLength = audioBuffer.frameLength
        let gainValue = gain(for: selectedProfile) * (1 + selectedIntensity * 0.5)
        let frames = Int(audioBuffer.frameLength)
        for ch in 0..<Int(audioBuffer.format.channelCount) {
            if let src = audioBuffer.floatChannelData?[ch], let dst = buffer.floatChannelData?[ch] {
                for i in 0..<frames { dst[i] = src[i] * gainValue }
            }
        }
        return buffer
    }

    /// Convenience overload using a non-optional profile parameter.
    public func applyTimbre(to buffer: AVAudioPCMBuffer,
                            profile: TimbreProfile) -> AVAudioPCMBuffer {
        applyTimbre(to: buffer, with: profile, intensity: nil)
    }

    /// Update the active timbre profile.
    public func setProfile(_ profile: TimbreProfile) {
        activeProfile = profile
    }

    /// Update modulation intensity clamped between 0 and 1.
    public func setIntensity(_ intensity: Float) {
        modulationIntensity = min(max(0.0, intensity), 1.0)
    }

    /// Return all available timbre profiles.
    public func availableProfiles() -> [TimbreProfile] {
        TimbreProfile.allCases
    }

    private func gain(for profile: TimbreProfile) -> Float {
        switch profile {
        case .warm: return 1.05
        case .sharp: return 1.15
        case .breathy: return 0.9
        case .deep: return 0.8
        case .robotic: return 1.0
        case .whispery: return 0.5
        case .cinematic: return 1.2
        }
    }
}
#else
import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Non-observable fallback when Combine is unavailable.
public final class VoiceTimbreModulator {
    public static let shared = VoiceTimbreModulator()

    public enum TimbreProfile: String, Codable, CaseIterable {
        case warm, sharp, breathy, deep, robotic, whispery, cinematic
    }

    private(set) public var activeProfile: TimbreProfile = .warm
    private(set) public var modulationIntensity: Float = 0.5

#if canImport(AVFoundation)
    public func applyTimbre(to audioBuffer: AVAudioPCMBuffer,
                            with profile: TimbreProfile? = nil,
                            intensity: Float? = nil) -> AVAudioPCMBuffer {
        let selectedProfile = profile ?? activeProfile
        let selectedIntensity = intensity ?? modulationIntensity
        guard let buffer = AVAudioPCMBuffer(pcmFormat: audioBuffer.format, frameCapacity: audioBuffer.frameCapacity) else {
            return audioBuffer
        }
        buffer.frameLength = audioBuffer.frameLength
        let gainValue = gain(for: selectedProfile) * (1 + selectedIntensity * 0.5)
        let frames = Int(audioBuffer.frameLength)
        for ch in 0..<Int(audioBuffer.format.channelCount) {
            if let src = audioBuffer.floatChannelData?[ch], let dst = buffer.floatChannelData?[ch] {
                for i in 0..<frames { dst[i] = src[i] * gainValue }
            }
        }
        return buffer
    }

    /// Convenience overload using a non-optional profile parameter.
    public func applyTimbre(to buffer: AVAudioPCMBuffer,
                            profile: TimbreProfile) -> AVAudioPCMBuffer {
        applyTimbre(to: buffer, with: profile, intensity: nil)
    }
#else
    public func applyTimbre(to audioBuffer: Any,
                            with profile: TimbreProfile? = nil,
                            intensity: Float? = nil) -> Any { audioBuffer }
#endif

    public func setProfile(_ profile: TimbreProfile) {
        activeProfile = profile
    }

    public func setIntensity(_ intensity: Float) {
        modulationIntensity = min(max(0.0, intensity), 1.0)
    }

    public func availableProfiles() -> [TimbreProfile] {
        TimbreProfile.allCases
    }

    private func gain(for profile: TimbreProfile) -> Float {
        switch profile {
        case .warm: return 1.05
        case .sharp: return 1.15
        case .breathy: return 0.9
        case .deep: return 0.8
        case .robotic: return 1.0
        case .whispery: return 0.5
        case .cinematic: return 1.2
        }
    }
}
#endif
