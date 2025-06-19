import Foundation

struct PromptTemplateLoader {
    let bundle: Bundle

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    func loadTemplates() -> [PromptTemplate] {
        guard let url = bundle.url(forResource: "prompts", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let array = try? JSONSerialization.jsonObject(with: data) as? [[String: String]] else {
            return []
        }
        return array.compactMap { dict in
            if let name = dict["name"], let text = dict["text"] {
                return PromptTemplate(name: name, text: text)
            }
            return nil
        }
    }
}
