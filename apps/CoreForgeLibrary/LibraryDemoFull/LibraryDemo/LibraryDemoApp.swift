import Foundation
#if canImport(SwiftUI)
import SwiftUI

@main
struct LibraryDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
#else
@main
struct LibraryDemoAppMain {
    static func main() {}
}
#endif
