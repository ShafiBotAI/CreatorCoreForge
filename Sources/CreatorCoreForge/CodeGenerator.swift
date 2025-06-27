import Foundation

/// Supported output languages for simple UI scaffolds.
public enum CodeLanguage {
    case react, vue, flutter, swiftUI, html
    case swift, kotlin, python, typescript
}

/// Very small demo code generator to illustrate language switching.
public enum CodeStyle {
    case minimalist, intermediate, verbose
}

public enum NetworkMode {
    case rest, graphQL
}

public struct CodeGenerator {
    public var style: CodeStyle
    public var metadata: [String: String]

    public init(style: CodeStyle = .minimalist, metadata: [String: String] = [:]) {
        self.style = style
        self.metadata = metadata
    }

    public func generateComponent(named name: String, language: CodeLanguage) -> String {
        let body: String
        switch language {
        case .react:
            body = "function \(name)() { return <div>\(name)</div>; }"
        case .vue:
            body = "<template><div>\(name)</div></template>"
        case .flutter:
            body = "class \(name): StatelessWidget { @override Widget build(BuildContext context) { return Text('$name'); } }"
        case .swiftUI:
            body = "struct \(name): View { var body: some View { Text(\"\(name)\") } }"
        case .html:
            body = "<div>\(name)</div>"
        case .swift:
            body = "class \(name): UIViewController {}"
        case .kotlin:
            body = "class \(name) : AppCompatActivity() { override fun onCreate(b: Bundle?) { super.onCreate(b) } }"
        case .python:
            body = "class \(name):\n    pass"
        case .typescript:
            body = "export function \(name)() { return '<div>\(name)</div>'; }"
        }

        var output = body
        if style != .minimalist {
            let comment = "// component: \(name)"
            output = comment + "\n" + body
        }
        if !metadata.isEmpty {
            let meta = metadata.map { "// \($0): \($1)" }.joined(separator: "\n")
            output = meta + "\n" + output
        }
        return output
    }

    public func generateNetworkLayer(mode: NetworkMode) -> String {
        switch mode {
        case .rest:
            return """
            import Foundation

            class RestClient {
                func request(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
                    guard let url = URL(string: url) else {
                        completion(.failure(URLError(.badURL)))
                        return
                    }
                    URLSession.shared.dataTask(with: url) { data, _, error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(data ?? Data()))
                        }
                    }.resume()
                }
            }
            """
        case .graphQL:
            return """
            import Foundation

            class GraphQLClient {
                func query(_ q: String, endpoint: URL, completion: @escaping (Result<Data, Error>) -> Void) {
                    var request = URLRequest(url: endpoint)
                    request.httpMethod = "POST"
                    request.httpBody = try? JSONSerialization.data(withJSONObject: ["query": q])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    URLSession.shared.dataTask(with: request) { data, _, error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(data ?? Data()))
                        }
                    }.resume()
                }
            }
            """
        }
    }

    public func importOpenAPISpec(json: String) -> [String] {
        guard let data = json.data(using: .utf8),
              let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let paths = obj["paths"] as? [String: Any] else {
            return ["unknown"]
        }
        return paths.keys.map { String($0) }
    }

    @discardableResult
    public func exportLanguageBundle(language: CodeLanguage, to path: String) -> Bool {
        let fm = FileManager.default
        try? fm.createDirectory(atPath: path, withIntermediateDirectories: true)
        let file = (path as NSString).appendingPathComponent("Sample.swift")
        let code = generateComponent(named: "Sample", language: language)
        return fm.createFile(atPath: file, contents: code.data(using: .utf8))
    }
}
