import Foundation
#if canImport(RealityKit) && canImport(ARKit)
import RealityKit
import ARKit
#endif

/// Basic AR/VR playback helper that renders a RealityKit scene when available.
public struct ARVRPlayback {
    #if canImport(RealityKit) && canImport(ARKit)
    private let arView: ARView

    public init(frame: CGRect = .zero) {
        self.arView = ARView(frame: frame)
    }

    /// Load and present a 3D scene. Returns the ARView for display.
    public func play(scene: String) -> ARView {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)

        if let entity = try? Entity.load(named: scene) {
            let anchor = AnchorEntity(world: .zero)
            anchor.addChild(entity)
            arView.scene.anchors.append(anchor)
        }
        return arView
    }
    #else
    public init() {}
    /// Returns a message for playing a scene when ARKit is unavailable.
    public func play(scene: String) -> String {
        "AR/VR playback not supported: \(scene)"
    }
    #endif
}
