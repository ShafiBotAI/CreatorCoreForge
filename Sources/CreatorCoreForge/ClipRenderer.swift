import Foundation

/// Renders a SceneClip into a RenderedClip with basic retry logic.
public final class ClipRenderer {
    private let effects = VideoEffectsPipeline()
    public init() {}

    /// Render the given scene clip using the provided voice mapping.
    public func render(sceneClip: SceneClip, voiceMap: VoiceMap) -> RenderedClip {
        var attempt = 0
        let maxAttempts = 2
        while attempt < maxAttempts {
            do {
                let voice = voiceMap[sceneClip.clipID] ?? "Narrator"
                let frames = [sceneClip.text, "voice:\(voice)", "tone:\(sceneClip.tone)"]
                let processed = effects.applyTransitions(to: frames, style: sceneClip.transitionType)
                return RenderedClip(frames: processed)
            } catch {
                attempt += 1
                print("ClipRenderer retry \(attempt) for \(sceneClip.clipID)")
            }
        }
        // Fallback empty clip on repeated failure
        return RenderedClip(frames: [])
    }
}
