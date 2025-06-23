import Foundation

/// Simple manager placeholder for multiplayer sessions.
public class MultiplayerManager {
    private var players: [String] = []

    public func join(playerID: String) {
        players.append(playerID)
    }

    public var playerCount: Int { players.count }
}
