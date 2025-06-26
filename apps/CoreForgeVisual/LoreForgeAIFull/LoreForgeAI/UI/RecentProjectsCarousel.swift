import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif

struct Project: Identifiable {
    let id = UUID()
    let title: String
}

#if canImport(SwiftUI)
final class RecentProjectsModel: ObservableObject {
    static let shared = RecentProjectsModel()
    @Published var projects: [Project] = []

    func add(_ title: String) {
        projects.insert(Project(title: title), at: 0)
    }
}

struct RecentProjectsCarousel: View {
    @ObservedObject var model = RecentProjectsModel.shared

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(model.projects) { project in
                    Text(project.title)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).stroke())
                }
            }
            .padding(.horizontal)
        }
    }
}
#else
final class RecentProjectsModel {
    static let shared = RecentProjectsModel()
    var projects: [Project] = []
    func add(_ title: String) { projects.insert(Project(title: title), at: 0) }
}
struct RecentProjectsCarousel {}
#endif
