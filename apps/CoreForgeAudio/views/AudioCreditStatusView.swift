#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Displays remaining export credits for the user.
struct AudioCreditStatusView: View {
    var credits: Int

    var body: some View {
        HStack {
            Label("Credits", systemImage: "creditcard")
            Spacer()
            Text(String(credits))
                .bold()
        }
        .padding()
        .background(Theme.cardMaterial)
        .cornerRadius(Theme.cornerRadius)
        .shadow(radius: Theme.shadowRadius)
    }
}

#Preview {
    AudioCreditStatusView(credits: 10)
}
#endif
