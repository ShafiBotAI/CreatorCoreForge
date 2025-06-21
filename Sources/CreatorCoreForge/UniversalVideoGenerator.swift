import Foundation

/// Generates rendered clips from text scenes for any app using shared modules.
public final class UniversalVideoGenerator {
    private let dramatizer: SceneDramatizer
    private let renderer: Renderer
    private let frameRenderer: FrameRenderer
    private let effects: VideoEffectsPipeline

    public init(dramatizer: SceneDramatizer = SceneDramatizer(),
                renderer: Renderer = Renderer(),
                frameRenderer: FrameRenderer = FrameRenderer(),
                effects: VideoEffectsPipeline = VideoEffectsPipeline()) {
        self.dramatizer = dramatizer
        self.renderer = renderer
        self.frameRenderer = frameRenderer
        self.effects = effects
    }

    /// Create a video clip using scene text, style, and audio label.
    public func generateClip(text: String,
                             style: RenderingStyle,
                             audio: String) -> RenderedClip {
        let clip = dramatizer.generateSceneVideo(sceneText: text)
        let styled = renderer.render(scene: text, style: style)
        let frames = clip.imageFrames + styled.assets
        let faded = effects.applyFadeTransitions(to: frames)
        let watermarked = effects.addWatermark(to: faded, watermark: "CCF")
        let rendered = frameRenderer.render(frames: watermarked)
        return effects.composeVideo(frames: rendered.frames, audio: audio)
    }
}
