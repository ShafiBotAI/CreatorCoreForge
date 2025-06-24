import Foundation

public struct RecordingTools {
    public func trim(_ samples: [Float], to count: Int) -> [Float] {
        Array(samples.prefix(count))
    }
}

public struct TrainingPipeline {
    public func prepare(samples: [Float]) -> Bool {
        !samples.isEmpty
    }
}

public struct ExportHooks {
    public func send(name: String) -> String {
        "Sent \(name)"
    }
}
