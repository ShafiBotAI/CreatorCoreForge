import Foundation

/// Combines audio blobs into a single data stream.
public struct StreamAssembler {
    public init() {}

    public func assemble(_ blobs: [AudioBlob]) -> AudioBlob {
        var data = Data()
        for blob in blobs { data.append(blob) }
        return data
    }
}

