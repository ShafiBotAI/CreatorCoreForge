import Foundation

/// Generates investor signals for founders.
public struct VCInvestorSignalTool {
    public init() {}

    public func signals(for founder: String) -> [String] {
        ["investor-interest-\(founder)"]
    }
}
