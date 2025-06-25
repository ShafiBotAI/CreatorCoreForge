#if canImport(AVFoundation)
import Foundation
import AVFoundation
import Combine

final class SpeechHighlighter: NSObject, ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var highlightRange: NSRange?
    var onFinish: (() -> Void)?

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    var isSpeaking: Bool { synthesizer.isSpeaking }

    func speak(_ text: String) {
        highlightRange = nil
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)
    }

    func pause() {
        synthesizer.pauseSpeaking(at: .immediate)
    }
}

extension SpeechHighlighter: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            self?.highlightRange = characterRange
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { [weak self] in
            self?.highlightRange = nil
            self?.onFinish?()
        }
    }
}
#endif
