import Foundation

/// Offline-first local AI engine that performs simple Markov chain generation
/// and deterministic embedding math so tests can run without network access.
public final class LocalAIEnginePro {
    public init() {}

    /// Generates a pseudo response by building a first-order Markov chain from
    /// the prompt text and sampling up to 40 words from that chain. This
    /// produces output that is unique but still based on the input data.
    public func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global().async {
            let words = prompt.split { !$0.isLetter }
            guard words.count > 1 else {
                completion(.success(prompt))
                return
            }

            var chain: [String: [String]] = [:]
            for (a, b) in zip(words, words.dropFirst()) {
                chain[String(a), default: []].append(String(b))
            }

            var current = String(words.first!)
            var result: [String] = [current]
            for _ in 0..<40 {
                guard let next = chain[current]?.randomElement() else { break }
                result.append(next)
                current = next
            }

            completion(.success(result.joined(separator: " ")))
        }
    }

    /// Computes a simple bag-of-words vector for the input text. The vector has
    /// a fixed length so repeated calls with the same text are stable.
    public func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
        DispatchQueue.global().async {
            let words = text.lowercased().split { !$0.isLetter }
            var counts: [String: Int] = [:]
            for w in words { counts[String(w), default: 0] += 1 }
            let sorted = counts.sorted { $0.key < $1.key }
            var vector: [Double] = sorted.map { Double($0.value) }
            if vector.count < 128 { vector.append(contentsOf: Array(repeating: 0, count: 128 - vector.count)) }
            if vector.count > 128 { vector = Array(vector.prefix(128)) }
            completion(.success(vector))
        }
    }

    /// Naive summarization returning the sentence with the highest keyword score.
    public func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global().async {
            let sentences = text.split(separator: ".")
            guard !sentences.isEmpty else {
                completion(.success(text))
                return
            }

            let stopWords: Set<String> = [
                "the", "a", "an", "and", "is", "it", "of", "to", "in", "on", "for",
                "with", "that", "this", "at", "by", "from", "as", "are", "be"
            ]
            let allWords = text.lowercased().split { !$0.isLetter }
                .map { String($0) }
                .filter { !stopWords.contains($0) }
            var freq: [String: Int] = [:]
            for w in allWords { freq[w, default: 0] += 1 }

            var bestSentence = sentences.first!
            var bestScore = -1
            for sentence in sentences {
                let words = sentence.lowercased().split { !$0.isLetter }
                    .map { String($0) }
                    .filter { !stopWords.contains($0) }
                let score = words.reduce(0) { $0 + (freq[$1] ?? 0) }
                if score > bestScore { bestScore = score; bestSentence = sentence }
            }

            completion(.success(String(bestSentence).trimmingCharacters(in: .whitespacesAndNewlines)))
        }
    }

    /// Very small sentiment analyzer used for demos. Counts positive and
    /// negative keywords and returns the dominant sentiment.
    public enum Sentiment: String {
        case positive, negative, neutral
    }

    public func analyzeSentiment(_ text: String) -> Sentiment {
        let positives: Set<String> = ["good", "great", "excellent", "amazing", "wonderful", "positive"]
        let negatives: Set<String> = ["bad", "terrible", "awful", "horrible", "negative", "poor"]

        var score = 0
        for word in text.lowercased().split(whereSeparator: { !$0.isLetter }) {
            if positives.contains(String(word)) { score += 1 }
            if negatives.contains(String(word)) { score -= 1 }
        }
        if score > 0 { return .positive }
        if score < 0 { return .negative }
        return .neutral
    }
}
