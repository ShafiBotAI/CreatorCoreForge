import Foundation

/// Converts voice notes into simple lead records.
public struct VoiceLeadDictation {
    public init() {}

    public func parse(note: String) -> Lead? {
        // Expect format "name,email,company,industry,region"
        let parts = note.split(separator: ",")
        guard parts.count == 5 else { return nil }
        return Lead(name: String(parts[0]),
                    email: String(parts[1]),
                    company: String(parts[2]),
                    industry: String(parts[3]),
                    region: String(parts[4]))
    }
}
