import SwiftUI

struct UnlockWithPromoView: View {
    @State private var promoCode: String = ""
    @State private var message: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Redeem Promo Code")
                .font(.title2)
            TextField("Enter code", text: $promoCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Button("Unlock") {
                redeem(code: promoCode)
            }
            .buttonStyle(.borderedProminent)
            if let message = message {
                Text(message)
                    .foregroundColor(AppTheme.accentColor)
            }
        }
        .padding()
    }
    
    private func redeem(code: String) {
        let trimmed = code.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            message = "Please enter a code."
            return
        }
        // Placeholder: store unlock flag locally
        UserDefaults.standard.set(true, forKey: "promoUnlocked")
        message = "Code redeemed!"
    }
}

struct UnlockWithPromoView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockWithPromoView()
    }
}
