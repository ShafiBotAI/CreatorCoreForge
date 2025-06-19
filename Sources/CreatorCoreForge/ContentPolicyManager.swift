import Foundation

public final class ContentPolicyManager {
    private static var bannedWords = ["nsfw", "explicit"]
    private static var bannedPatterns: [NSRegularExpression] = []
    public static var ageLimit = 18

    public static func isAllowed(text: String, nsfw: Bool, age: Int = ageLimit) -> Bool {
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

    public static func sanitize(_ text: String, replacement: String = "***") -> String {
        var cleaned = text
        for word in bannedWords {
            cleaned = cleaned.replacingOccurrences(of: word, with: replacement, options: .caseInsensitive)
        }
        for regex in bannedPatterns {
            let range = NSRange(cleaned.startIndex..<cleaned.endIndex, in: cleaned)
            cleaned = regex.stringByReplacingMatches(in: cleaned, options: [], range: range, withTemplate: replacement)
        }
        return cleaned
    }

    public static func addBannedWord(_ word: String) {
        bannedWords.append(word.lowercased())
    }

    public static func addBannedPattern(_ pattern: String) {
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            bannedPatterns.append(regex)
        }
    }

    public static func updatePolicy(for age: Int) {
        ageLimit = age
        if age < 18 {
            addBannedWord("violent")
        }
    }
}
