import Foundation

/// Basic voice control integration service.
/// Consumers can route recognized voice commands to this service
/// which then forwards callbacks to the application layer.
public final class VoiceControlService {
    public enum VoiceCommand {
        case play, pause, stop, next, previous
        case custom(String)

        public var rawValue: String {
            switch self {
            case .play: return "play"
            case .pause: return "pause"
            case .stop: return "stop"
            case .next: return "next"
            case .previous: return "previous"
            case .custom(let v): return v
            }
        }
    }

    /// Optional handler invoked when a command is received.
    public var onCommand: ((VoiceCommand) -> Void)?

    public init() {}

    /// Send a command to the voice controller.
    /// The command is dispatched to the `onCommand` closure if set.
    public func sendCommand(_ command: VoiceCommand) {
        onCommand?(command)
    }
}
