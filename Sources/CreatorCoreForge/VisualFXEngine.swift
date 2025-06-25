import Foundation

/// Provides basic particle, weather, and lighting configuration per scene.
public struct VisualFXEngine {
    /// Simple FX settings returned by the engine.
    public struct FXSettings {
        public var particles: String
        public var weather: String
        public var lighting: String
        public init(particles: String = "none",
                    weather: String = "clear",
                    lighting: String = "day") {
            self.particles = particles
            self.weather = weather
            self.lighting = lighting
        }
    }

    public init() {}

    /// Generate FX settings for a given scene node.
    public func fx(for scene: SceneNode) -> FXSettings {
        FXSettings(particles: "basic",
                   weather: "clear",
                   lighting: scene.tone == .negative ? "night" : "day")
    }
}
