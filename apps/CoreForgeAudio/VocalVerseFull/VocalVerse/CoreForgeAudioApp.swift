#if canImport(SwiftUI)
import SwiftUI
#if canImport(FirebaseCore)
import FirebaseCore
#endif

@main
struct CoreForgeAudioApp: App {
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
struct CoreForgeAudioApp {}
#endif
