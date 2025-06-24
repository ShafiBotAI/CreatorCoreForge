import Foundation
import CreatorCoreForge

/// High level manager that orchestrates generating scenes and exporting a video.
public final class VideoExportManager {
    private let sceneGenerator: VideoSceneGenerator
    private let caster: VoiceCastingEngine
    private let renderer: RendererControl
    private let voiceMapper = CharacterVoiceMapper()

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
        _ = voiceMapper.assignVoices(to: bookText)
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
        _ = voiceMapper.assignVoices(to: bookText)
        let voiced = caster.assignVoices(to: scenes)
        renderer.exportMultiHourVideo(scenes: voiced,
                                     to: outputURL,
                                     metadata: metadata,
                                     nsfw: nsfw,
                                     birthDate: birthDate,
                                      progress: progress,
                                      completion: completion)
    }

    /// Export only the most emotional scenes as a highlight reel.
    public func exportMoodMix(bookText: String,
                              to outputURL: URL,
                              intensityThreshold: Double = 0.5,
                              nsfw: Bool = false,
                              birthDate: Date = Date(timeIntervalSince1970: 0),
                              progress: @escaping (Double) -> Void,
                              completion: @escaping (URL?) -> Void) {
        let scenes = sceneGenerator.generateScenes(from: bookText)
        let analyzer = EmotionAnalyzer()
        let highlights = scenes.filter { scene in
            Double(analyzer.analyzeEmotion(from: scene.description).intensity) >= intensityThreshold
        }
        guard !highlights.isEmpty else {
            completion(nil)
            return
        }
        _ = voiceMapper.assignVoices(to: bookText)
        let voiced = caster.assignVoices(to: highlights)
        renderer.exportMultiHourVideo(scenes: voiced,
                                     to: outputURL,
                                     metadata: ["filter": "moodmix"],
                                     nsfw: nsfw,
                                     birthDate: birthDate,
                                     progress: progress,
                                     completion: completion)
    }
}
