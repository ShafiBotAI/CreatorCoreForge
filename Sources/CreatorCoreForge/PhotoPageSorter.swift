import Foundation

/// Sorts OCR'd page images into logical order based on detected page numbers.
public final class PhotoPageSorter {
    private let ocr: OCRScanMode
    public init(ocr: OCRScanMode = OCRScanMode()) {
        self.ocr = ocr
    }

    /// Return texts extracted from images, ordered by detected page numbers.
    /// If no page number is found, the original index is used.
    public func orderedTexts(from images: [Data]) -> [String] {
        let pages: [(order: Int, text: String)] = images.enumerated().map { idx, data in
            let text = ocr.extractText(from: data)
            let num = PhotoPageSorter.detectPageNumber(in: text) ?? idx
            return (num, text)
        }
        return pages.sorted { $0.order < $1.order }.map { $0.text }
    }

    /// Combine pages into a single document string in logical order.
    public func combinedText(from images: [Data]) -> String {
        orderedTexts(from: images).joined(separator: "\n")
    }

    private static func detectPageNumber(in text: String) -> Int? {
        let pattern = "(?im)^\\s*(?:page\\s*)?(\\d{1,4})\\s*$"
        for line in text.components(separatedBy: .newlines) {
            if let match = line.range(of: pattern, options: .regularExpression) {
                return Int(line[match].trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted))
            }
        }
        return nil
    }
}
