import Foundation

/// Supported output languages for simple UI scaffolds.
public enum CodeLanguage {
    case react, vue, flutter, swiftUI, html
}

/// Very small demo code generator to illustrate language switching.
public struct CodeGenerator {
    public init() {}

    public func generateComponent(named name: String, language: CodeLanguage) -> String {
        switch language {
        case .react:
            return "function \(name)() { return <div>\(name)</div>; }"
        case .vue:
            return "<template><div>\(name)</div></template>"
        case .flutter:
            return "class \(name): StatelessWidget { @override Widget build(BuildContext context) { return Text('$name'); } }"
        case .swiftUI:
            return "struct \(name): View { var body: some View { Text(\"\(name)\") } }"
        case .html:
            return "<div>\(name)</div>"
        }
    }
}
