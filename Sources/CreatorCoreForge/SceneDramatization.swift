import Foundation

/// Verifies that a user is at least 18 based on a YYYY-MM-DD date string.
public struct AgeVerifier {
    public init() {}
    public func isAdult(dob: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dob) else { return false }
        return DOBCheck.isOfAge(birthdate: date)
    }
}

/// Represents an audio/visual clip for a single scene.
public struct VideoClip {
    public var sceneText: String
    public var voiceFile: String
    public var imageFrames: [String]
}

/// Generates basic visuals and voice for a line of scene text.
public final class SceneDramatizer {
    public init() {}
    public func generateSceneVideo(sceneText: String) -> VideoClip {
        let voiceFile = "/local/voice/scene_1.mp3"
        let frames = ["/local/images/frame1.png", "/local/images/frame2.png"]
        return VideoClip(sceneText: sceneText, voiceFile: voiceFile, imageFrames: frames)
    }
}

/// Rendering style options shared across apps.
public enum RenderingStyle: String {
    case anime, liveAction, fantasy
}

/// Result of rendering a scene with a given style.
public struct RenderedScene {
    public var style: RenderingStyle
    public var assets: [String]
}

/// Offline renderer that tags scenes with a visual style.
public final class Renderer {
    public init() {}
    public func render(scene: String, style: RenderingStyle) -> RenderedScene {
        let asset = "/assets/scenes/\(style.rawValue)/scene_base.png"
        return RenderedScene(style: style, assets: [asset])
    }
}

/// Controls where rendered scenes can be uploaded based on plan and platform.
public final class Uploader {
    public init() {}
    public func upload(scene: RenderedScene, to platform: String, userPlan: String) -> Bool {
        let allowed = (userPlan == "creator" || userPlan == "pro") || platform == "defaultPlatform"
        return allowed
    }
}
