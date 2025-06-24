import Foundation

/// Basic voice control integration service.
/// Consumers can route recognized voice commands to this service
/// which then forwards callbacks to the application layer.
public final class VoiceControlService {
    public enum VoiceCommand: String {
        case play, pause, stop, next, previous
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
