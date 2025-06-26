#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Placeholder root view for the demo application.
struct ContentView: View {
    var body: some View {
        Text("CreatorCoreForge Audio")
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
#endif
