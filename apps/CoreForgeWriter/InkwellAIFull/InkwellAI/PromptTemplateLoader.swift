import Foundation

struct PromptTemplateLoader {
    let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    /// Load all available prompt templates from the bundled `prompts.json` file.
    /// Any malformed entries are skipped rather than causing the load to fail.
    func loadTemplates() -> [PromptTemplate] {
        guard let url = bundle.url(forResource: "prompts", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let array = try? JSONSerialization.jsonObject(with: data) as? [[String: String]] else {
            return []
        }
        return array.reduce(into: [PromptTemplate]()) { result, dict in
            if let name = dict["name"], let text = dict["text"] {
                result.append(PromptTemplate(name: name, text: text))
            }
        }
    }
}
