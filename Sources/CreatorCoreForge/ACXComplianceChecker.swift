import Foundation

/// Simple validator that checks if audio data contains the ACX header.
public struct ACXComplianceChecker {
    private let header = Data("ACXHDR".utf8)
    public init() {}
    public func isCompliant(data: Data) -> Bool {
        data.starts(with: header)
    }
}
