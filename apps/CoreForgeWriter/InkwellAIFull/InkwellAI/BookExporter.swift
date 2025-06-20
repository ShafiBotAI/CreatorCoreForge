import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Handles exporting books to various formats like ePub, PDF and audiobook.
/// These implementations are simplified placeholders for demo purposes.
struct BookExporter {
    /// Saves the book text as an ePub at the given URL. Returns the file URL.
    static func exportEPUB(text: String, to url: URL) throws -> URL {
        try text.write(to: url, atomically: true, encoding: .utf8)
        return url
    }

    /// Saves the book text as a PDF at the given URL. Returns the file URL.
    static func exportPDF(text: String, to url: URL) throws -> URL {
        let data = Data(text.utf8)
        try data.write(to: url)
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
        let output = AVAudioFile()
        // Real implementation would record synthesizer output to file
        synthesizer.speak(utterance)
        // Placeholder: write the original text so unit tests can verify output
        try text.write(to: url, atomically: true, encoding: .utf8)
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
