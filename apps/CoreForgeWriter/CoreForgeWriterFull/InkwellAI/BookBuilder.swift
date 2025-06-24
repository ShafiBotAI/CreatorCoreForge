import Foundation

final class BookBuilder {

    private func buildPreface(for title: String, style: String?) -> String {
        let styleNote = style.map { " in the style of \($0)" } ?? ""
        return "Preface\nWelcome to \(title)\(styleNote).\n\n"
    }

    private func buildEpilogue(for title: String, memory: MemoryTracker?) -> String {
        if let summary = memory?.summarizeContext(last: 5), !summary.isEmpty {
            return "Epilogue\n\(summary)\nThank you for reading \(title)."
        } else {
            return "Epilogue\nThank you for reading \(title)."
        }
    }
    /// Build a full book using the provided chapters. When `fastDraft` is true
    /// only a short summary of each chapter is inserted. A `MemoryTracker` can
    /// be passed to keep track of generated content for continuity checks.
    func generateBook(title: String,
                      seriesTitle: String? = nil,
                      chapters: [String],
                      genre: GenreTemplate? = nil,
                      includeEpilogue: Bool = false,
                      includePreface: Bool = false,
                      style: String? = nil,
                      chapterPrefix: String = "Chapter",
                      fastDraft: Bool = false,
                      memory: MemoryTracker? = nil,
                      allowNSFW: Bool = false,
                      language: String = "English") -> String {
        var header = "# \(title)\n"
        if let series = seriesTitle {
            header += "Series: \(series)\n"
        }
        var allChapters = chapters
        if let template = genre {
            allChapters = template.outline + chapters
        }

        let body = allChapters.enumerated().map { index, text in
            var content: String
            if fastDraft {
                let snippet = text.split(separator: ".").first.map(String.init) ?? text
                content = "[Draft] \(snippet)..."
            } else {
                content = allowNSFW ? text : ContentPolicyManager.sanitize(text)
            }
            let chapterTitle = "\(chapterPrefix) \(index + 1)"
            memory?.record("\(chapterTitle): \(content)")
            return "\(chapterTitle)\n\(content)"
        }.joined(separator: "\n\n")

        var book = header
        if let style = style {
            book += "Style: \(style)\n\n"
        }
        if includePreface {
            book += buildPreface(for: title, style: style)
        }
        book += body
        if includeEpilogue {
            book += "\n\n" + buildEpilogue(for: title, memory: memory)
        }
        let final = book + "\n\nThe End"
        return Translator.translate(final, to: language)
    }

    /// Split a large collection of chapters into multiple books. Each book will
    /// contain at most `chaptersPerBook` chapters.
    func generateSeries(title: String,
                        chapters: [String],
                        chaptersPerBook: Int = 50,
                        genre: GenreTemplate? = nil,
                        allowNSFW: Bool = false) -> [String] {
        guard !chapters.isEmpty else { return [] }
        let parts = stride(from: 0, to: chapters.count, by: chaptersPerBook).map {
            Array(chapters[$0..<min($0 + chaptersPerBook, chapters.count)])
        }
        return parts.enumerated().map { index, slice in
            let volumeTitle = "\(title) Vol. \(index + 1)"
            return generateBook(title: volumeTitle,
                                seriesTitle: title,
                                chapters: slice,
                                genre: genre,
                                includeEpilogue: true,
                                includePreface: true,
                                allowNSFW: allowNSFW)
        }
    }
}
