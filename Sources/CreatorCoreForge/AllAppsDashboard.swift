#if canImport(SwiftUI)
import SwiftUI

/// Displays completion status for each CreatorCoreForge app.
public struct AllAppsDashboard: View {
    struct Completion: Decodable {
        let done: Int
        let total: Int
        let percent_complete: Double
    }

    let data: [String: Completion]

    public init(reportURL: URL = Bundle.module.url(forResource: "app_completion_report", withExtension: "json") ?? URL(fileURLWithPath: "app_completion_report.json", relativeTo: .init(fileURLWithPath: "."))) {
        let url = reportURL
        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([String: Completion].self, from: data) {
            self.data = decoded
        } else {
            self.data = [:]
        }
    }

    public var body: some View {
        NavigationView {
            List(AppCatalog.all, id: \.name) { info in
                VStack(alignment: .leading) {
                    HStack {
                        Text(info.name).font(.headline)
                        Spacer()
                        if let c = data[info.name] {
                            Text(String(format: "%.0f%%", c.percent_complete))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    Text(info.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("All Apps")
        }
    }
}
#endif
