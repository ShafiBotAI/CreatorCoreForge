import Foundation

public struct OptionPosition {
    public let delta: Double
    public let gamma: Double
    public let quantity: Int

    public init(delta: Double, gamma: Double, quantity: Int) {
        self.delta = delta
        self.gamma = gamma
        self.quantity = quantity
    }
}

public final class GammaExposureTracker {
    public init() {}

    public func totalGamma(for positions: [OptionPosition]) -> Double {
        positions.reduce(0) { $0 + $1.gamma * Double($1.quantity) }
    }
}
