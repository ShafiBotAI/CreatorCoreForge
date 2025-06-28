#if canImport(SwiftUI)
import SwiftUI

/// Displays a log of earned credits.
struct CreditsHistoryView: View {
    @ObservedObject var store = CreditStore.shared

    var body: some View {
        List(store.history, id: \.self) { entry in
            Text(entry)
        }
        .navigationTitle("Credit History")
    }
}

#Preview {
    CreditsHistoryView()
}
#endif
