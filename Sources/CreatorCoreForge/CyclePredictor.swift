import Foundation

/// Basic cycle predictor adapted from the MIT licensed
/// `menstrual_cycle_analysis` project by iurteaga.
public struct CyclePredictor {
    private var cycleLengths: [Int]

    public init(lengths: [Int] = []) {
        self.cycleLengths = lengths
    }

    public mutating func add(length: Int) {
        cycleLengths.append(length)
    }

    /// Returns predicted cycle length using simple mean of recorded lengths.
    public var predictedLength: Int {
        guard !cycleLengths.isEmpty else { return 28 }
        let total = cycleLengths.reduce(0, +)
        let mean = Double(total) / Double(cycleLengths.count)
        return Int(round(mean))
    }
}
