import Foundation

/// Parses rudimentary voice commands for trading actions.
public struct VoiceTradeAssistant {
    public init() {}

    public func handle(command: String) -> String {
        let cmd = command.lowercased()
        if cmd.contains("buy") { return "order:buy" }
        if cmd.contains("sell") { return "order:sell" }
        return "unrecognized"
    }
}
