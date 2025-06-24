import Foundation

/// Simulates a live ensemble chat room.
public final class LiveEnsembleRoom {
    private(set) var messages: [String] = []
    public init() {}

    public func post(_ message: String) {
        messages.append(message)
    }
}
