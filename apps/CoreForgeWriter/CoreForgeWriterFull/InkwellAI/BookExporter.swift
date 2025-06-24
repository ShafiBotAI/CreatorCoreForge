import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif
#if canImport(UIKit)
import UIKit
#endif

/// Handles exporting books to various formats like ePub, PDF and audiobook.
struct BookExporter {
    /// Saves the book text as an ePub at the given URL. Returns the file URL.
    static func exportEPUB(text: String, to url: URL) throws -> URL {
        let tempDir = url.deletingLastPathComponent()
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: tempDir,
                                                withIntermediateDirectories: true)
        let html = "<html><body>\n" + text.replacingOccurrences(of: "\n", with: "<br>") + "\n</body></html>"
        try html.write(to: tempDir.appendingPathComponent("index.html"),
                       atomically: true, encoding: .utf8)
        try FileManager.default.zipItem(at: tempDir, to: url)
        try FileManager.default.removeItem(at: tempDir)
        return url
    }

    /// Saves the book text as a PDF at the given URL. Returns the file URL.
    static func exportPDF(text: String, to url: URL) throws -> URL {
#if canImport(UIKit)
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792))
        try renderer.writePDF(to: url) { ctx in
            ctx.beginPage()
            let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            text.draw(in: CGRect(x: 20, y: 20, width: 572, height: 752), withAttributes: attrs)
        }
#else
        try text.write(to: url, atomically: true, encoding: .utf8)
#endif
        return url
    }

    #if canImport(AVFoundation)
    /// Generates a spoken-word audiobook and writes it to the given URL.
    /// This demo uses AVSpeechSynthesizer to produce the audio sequentially.
    static func exportAudiobook(text: String, to url: URL, voice: AVSpeechSynthesisVoice? = nil, rate: Float = AVSpeechUtteranceDefaultSpeechRate) throws -> URL {
        let mapper = CharacterVoiceMapper()
        _ = mapper.assignVoices(to: text)

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        utterance.rate = rate
        let synthesizer = AVSpeechSynthesizer()
        let engine = AVAudioEngine()
        let output = try AVAudioFile(forWriting: url, settings: engine.outputNode.outputFormat(forBus: 0).settings)
        synthesizer.write(utterance) { buffer in
            guard let pcm = buffer as? AVAudioPCMBuffer else { return }
            try? output.write(from: pcm)
        }
        return url
    }
    #else
    static func exportAudiobook(text: String, to url: URL, voice: Any? = nil, rate: Float = 0) throws -> URL {
        let mapper = CharacterVoiceMapper()
        _ = mapper.assignVoices(to: text)
        try text.write(to: url, atomically: true, encoding: .utf8)
        return url
    }
    #endif
}
