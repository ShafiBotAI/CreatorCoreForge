import Foundation

/// Represents an audio track used for mixing.
public struct ProductionTrack {
    public let name: String
    public let samples: [Int]
    public init(name: String, samples: [Int]) {
        self.name = name
        self.samples = samples
    }
}

/// Holds the result of a combined audio/video render.
public struct ProductionResult {
    public let audioMix: [Int]
    public let frames: [String]
}

/// Simple orchestrator for multitrack audio and video production.
public final class MultiTrackProductionSuite {
    private let editor: MultiTrackEditor
    private let exporter: ExportProduction

    public init(editor: MultiTrackEditor = MultiTrackEditor(),
                exporter: ExportProduction = ExportProduction()) {
        self.editor = editor
        self.exporter = exporter
    }

    /// Mix audio tracks and export frames with an optional watermark.
    public func produce(tracks: [ProductionTrack],
                        frames: [String],
                        watermark: String? = nil) -> ProductionResult {
        let mix = editor.mix(tracks: tracks.map { $0.samples })
        let exported = exporter.export(frames: frames, watermark: watermark)
        return ProductionResult(audioMix: mix, frames: exported)
    }
}
