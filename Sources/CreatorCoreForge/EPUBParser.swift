import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
/// Uses the system `unzip` command to extract EPUB files.

/// Simple EPUB parser that extracts chapter text from HTML files.
struct EPUBParser {
    static func chapters(from url: URL) throws -> [Chapter] {
        let fm = FileManager.default
        let tmp = fm.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try fm.createDirectory(at: tmp, withIntermediateDirectories: true)
        defer { try? fm.removeItem(at: tmp) }
        let proc = Process()
        proc.executableURL = URL(fileURLWithPath: "/usr/bin/unzip")
        proc.arguments = ["-q", url.path, "-d", tmp.path]
        try proc.run()
        proc.waitUntilExit()

        let containerURL = tmp.appendingPathComponent("META-INF/container.xml")
        guard let containerData = try? Data(contentsOf: containerURL),
              let rootPath = parseRootPath(containerData) else {
            throw BookImportError.parsingFailure
        }
        let opfURL = tmp.appendingPathComponent(rootPath)
        guard let opfData = try? Data(contentsOf: opfURL) else {
            throw BookImportError.parsingFailure
        }
        let htmlPaths = parseSpine(opfData)
        var chapters: [Chapter] = []
        for (idx, path) in htmlPaths.enumerated() {
            let htmlURL = opfURL.deletingLastPathComponent().appendingPathComponent(path)
            guard let data = try? Data(contentsOf: htmlURL),
                  let text = extractText(data) else { continue }
            let title = "Chapter \(idx + 1)"
            chapters.append(Chapter(title: title, text: text, order: idx))
        }
        return chapters
    }

    private static func parseRootPath(_ data: Data) -> String? {
        let handler = ContainerHandler()
        let parser = XMLParser(data: data)
        parser.delegate = handler
        parser.parse()
        return handler.rootFile
    }

    private static func parseSpine(_ data: Data) -> [String] {
        let handler = OPFHandler()
        let parser = XMLParser(data: data)
        parser.delegate = handler
        parser.parse()
        return handler.spine.compactMap { handler.manifest[$0] }
    }

    private static func extractText(_ data: Data) -> String? {
        guard var html = String(data: data, encoding: .utf8) else { return nil }
        html = html.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression)
        html = html.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        return html.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private class ContainerHandler: NSObject, XMLParserDelegate {
        var rootFile: String?
        func parser(_ parser: XMLParser, didStartElement name: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            if name == "rootfile" {
                rootFile = attributeDict["full-path"]
            }
        }
    }

    private class OPFHandler: NSObject, XMLParserDelegate {
        var manifest: [String: String] = [:]
        var spine: [String] = []
        func parser(_ parser: XMLParser, didStartElement name: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            if name == "item" {
                if let id = attributeDict["id"], let href = attributeDict["href"] {
                    manifest[id] = href
                }
            } else if name == "itemref" {
                if let idref = attributeDict["idref"] {
                    spine.append(idref)
                }
            }
        }
    }
}
