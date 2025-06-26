import Foundation
#if canImport(SwiftUI)
import SwiftUI

@main
struct CoreForgeLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
#else
@main
struct CoreForgeLibraryAppMain {
    static func main() {}
}
#endif
