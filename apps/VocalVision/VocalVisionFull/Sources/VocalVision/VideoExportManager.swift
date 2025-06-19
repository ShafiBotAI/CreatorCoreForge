import Foundation

/// High level manager that orchestrates generating scenes and exporting a video.
public final class VideoExportManager {
    private let sceneGenerator: VideoSceneGenerator
    private let caster: VoiceCastingEngine
    private let renderer: RendererControl

    public init(sceneGenerator: VideoSceneGenerator = VideoSceneGenerator(),
                caster: VoiceCastingEngine = VoiceCastingEngine(),
                renderer: RendererControl = RendererControl()) {
        self.sceneGenerator = sceneGenerator
        self.caster = caster
        self.renderer = renderer
    }

    /// Converts book text to a fully rendered video on disk.
    public func export(bookText: String,
                       to outputURL: URL,
                       nsfw: Bool = false,
                       birthDate: Date = Date(timeIntervalSince1970: 0),
                       progress: @escaping (Double) -> Void,
                       completion: @escaping (URL?) -> Void) {
        let scenes = sceneGenerator.generateScenes(from: bookText)
        let voiced = caster.assignVoices(to: scenes)
        renderer.exportMultiHourVideo(scenes: voiced,
                                      to: outputURL,
                                      metadata: nil,
                                      nsfw: nsfw,
                                      birthDate: birthDate,
                                      progress: progress,
                                      completion: completion)
    }

    /// Convenience wrapper for exporting an unabridged three hour dramatization.
    /// This simply forwards to `export` while attaching `unabridged=3h` metadata
    /// so downstream services can differentiate the longer render.
    public func exportUnabridgedThreeHour(bookText: String,
                                          to outputURL: URL,
                                          nsfw: Bool = false,
                                          birthDate: Date = Date(timeIntervalSince1970: 0),
                                          progress: @escaping (Double) -> Void,
                                          completion: @escaping (URL?) -> Void) {
        var metadata = ["unabridged": "3h"]
        let scenes = sceneGenerator.generateScenes(from: bookText)
        let voiced = caster.assignVoices(to: scenes)
        renderer.exportMultiHourVideo(scenes: voiced,
                                      to: outputURL,
                                      metadata: metadata,
                                      nsfw: nsfw,
                                      birthDate: birthDate,
                                      progress: progress,
                                      completion: completion)
    }
}
