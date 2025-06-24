import Foundation

/// Basic multiplayer session manager with join/leave and message
/// broadcasting utilities. All data is kept in-memory for demo
/// purposes.
public final class MultiplayerManager {
    private var players: [String: Date] = [:]
    public let sessionID = UUID()

    public init() {}

    /// Join the active session.
    public func join(playerID: String) {
        players[playerID] = Date()
    }

    /// Leave the active session.
    public func leave(playerID: String) {
        players.removeValue(forKey: playerID)
    }

    /// Send a message to all players. Returns the messages as they
    /// would appear on each client.
    public func broadcast(_ message: String) -> [String] {
        players.keys.map { "[\($0)]: \(message)" }
    }

    public var playerCount: Int { players.count }
    public var activePlayers: [String] { Array(players.keys) }
}
