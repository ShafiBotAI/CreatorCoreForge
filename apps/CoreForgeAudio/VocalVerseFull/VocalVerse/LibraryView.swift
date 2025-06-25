#if canImport(SwiftUI)
import SwiftUI

struct LibraryView: View {
    var body: some View {
        NavigationView {
            Text("Library")
                .font(.largeTitle)
                .padding()
                .navigationTitle("Library")
        }
    }
}
#endif
