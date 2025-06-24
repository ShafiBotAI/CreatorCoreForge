import Foundation

// MARK: - eBook Import Pipeline

public enum EbookFormat {
    case txt, pdf, epub, unsupported
}

public class EbookImporter {
    public init() {}
    public func detectFormat(filename: String) -> EbookFormat {
        if filename.hasSuffix(".txt") {
            return .txt
        } else if filename.hasSuffix(".pdf") {
            return .pdf
        } else if filename.hasSuffix(".epub") {
            return .epub
        }
        return .unsupported
    }

    public func importEbook(from filePath: String) -> [String] {
        let format = detectFormat(filename: filePath)
        switch format {
            case .txt:
                return importTxt(filePath)
            case .pdf:
                return importPdf(filePath)
            case .epub:
                return importEpub(filePath)
            default:
                print("Unsupported format.")
                return []
        }
    }

    private func importTxt(_ filePath: String) -> [String] {
        guard let content = try? String(contentsOfFile: filePath) else {
            print("Failed to read text file.")
            return []
        }
        return splitIntoChapters(content)
    }

    private func importPdf(_ filePath: String) -> [String] {
        // Simulated PDF import (real logic would use PDFKit)
        print("Importing PDF (simulated): \(filePath)")
        let simulatedText = "Chapter 1\nOnce upon a time...\n\nChapter 2\nThe journey continued..."
        return splitIntoChapters(simulatedText)
    }

    private func importEpub(_ filePath: String) -> [String] {
        // Simulated EPUB import
        print("Importing EPUB (simulated): \(filePath)")
        let simulatedText = "Chapter 1\nA new world begins...\n\nChapter 2\nTwists and turns await..."
        return splitIntoChapters(simulatedText)
    }

    private func splitIntoChapters(_ content: String) -> [String] {
        let rawChapters = content.components(separatedBy: "\n\n")
        return rawChapters.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }
}
