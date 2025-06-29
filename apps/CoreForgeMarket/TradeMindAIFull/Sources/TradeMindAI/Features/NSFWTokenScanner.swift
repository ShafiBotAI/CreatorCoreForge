import Foundation

public struct NSFWTokenScanner {
    private let blocked: Set<String>

    public init(blocked: Set<String> = ["XXX", "BAD"]) {
        self.blocked = blocked
    }

    public func containsNSFW(tokens: [String]) -> Bool {
        !blocked.isDisjoint(with: tokens.map { $0.uppercased() })
    }
}
