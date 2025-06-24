import Foundation

final class ContentPolicyManager {
    private static var bannedWords = ["nsfw", "explicit"]
    private static var bannedPatterns: [NSRegularExpression] = []
    private static var ageLimit = 18

    static func isAllowed(text: String, nsfw: Bool, age: Int = ageLimit) -> Bool {
        guard age >= ageLimit else { return false }

        if !nsfw {
            let lower = text.lowercased()
            for word in bannedWords {
                if lower.contains(word) {
                    return false
                }
            }
            for regex in bannedPatterns {
                if regex.firstMatch(in: lower, range: NSRange(lower.startIndex..<lower.endIndex, in: lower)) != nil {
                    return false
                }
            }
        }
        return true
    }

    static func addBannedWord(_ word: String) {
        bannedWords.append(word.lowercased())
    }

    static func addBannedPattern(_ pattern: String) {
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            bannedPatterns.append(regex)
        }
    }

    static func updatePolicy(for age: Int) {
        ageLimit = age
        if age < 18 {
            addBannedWord("violent")
        }
    }
}
