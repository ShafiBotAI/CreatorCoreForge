import SwiftUI

struct PlaceholderView: View {
    @State private var exports = 0

    var body: some View {
        VStack(spacing: 12) {
            Text("CoreForge Visual")
                .font(.title)
            Button("Export Scene (\(exports))") {
                exports += 1
            }
        }
        .padding()
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
