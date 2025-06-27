import Foundation
import CreatorCoreForge
#if canImport(NaturalLanguage)
import NaturalLanguage
#endif

/// Voice assignment engine used by the audio app.
/// Leverages NaturalLanguage sentiment analysis when available
/// to choose a voice that matches the text mood.
struct VoiceAssigner {
    static func assignVoice(for text: String) -> Voice {
        if let favID = FavoriteVoiceService.shared.favorites.first,
           let fav = VoiceConfig.voices.first(where: { $0.id == favID }) {
            return fav
        }

        #if canImport(NaturalLanguage)
        if #available(iOS 12.0, macOS 10.14, *) {
            let analyzer = NLSentimentAnalyzer()
            if let score = try? analyzer.predictedSentiment(for: text) {
                switch score {
                case .positive:
                    if let v = VoiceConfig.voices.first(where: { $0.id == "athena" }) { return v }
                case .negative:
                    if let v = VoiceConfig.voices.first(where: { $0.id == "zeus" }) { return v }
                default:
                    break
                }
            }
        }
        #endif

        if text.count > 200 {
            return Voice(id: "narrator", name: "Narrator")
        }

        let lowercased = text.lowercased()
        if lowercased.contains("wow") || lowercased.contains("incredible") {
            return Voice(id: "celebrity", name: "Celebrity")
        }

        return VoiceConfig.voices.first ?? Voice(id: "default", name: "Default")
    }
}
