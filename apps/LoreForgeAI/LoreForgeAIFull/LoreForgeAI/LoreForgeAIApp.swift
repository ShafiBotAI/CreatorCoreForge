import Foundation
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(FirebaseCore)
import FirebaseCore
#endif

#if canImport(SwiftUI)
@main
struct LoreForgeAIApp: App {
    init() {
#if canImport(FirebaseCore)
        FirebaseApp.configure()
#endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
#else
struct LoreForgeAIApp {}
#endif
