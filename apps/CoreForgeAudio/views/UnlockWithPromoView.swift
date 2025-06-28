#if canImport(SwiftUI)
import SwiftUI

/// Simple promo code unlock screen.
struct UnlockWithPromoView: View {
    @State private var code = ""
    @Environment(\.dismiss) private var dismiss
    private let manager = SubscriptionManager.shared

    var body: some View {
        NavigationView {
            Form {
                TextField("Promo Code", text: $code)
                Button("Apply") { applyCode() }
            }
            .navigationTitle("Promo Code")
        }
    }

    private func applyCode() {
        switch code.uppercased() {
        case "CREATORACCESS":
            manager.select(plan: .creator, cycle: .monthly)
        case "VISIONBETA":
            manager.select(plan: .enterprise, cycle: .monthly)
        default:
            break
        }
        dismiss()
    }
}

#Preview { UnlockWithPromoView() }
#endif
