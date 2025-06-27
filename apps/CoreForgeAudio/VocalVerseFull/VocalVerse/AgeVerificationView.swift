#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Prompts the user for a date of birth and verifies they are old enough
/// to enable NSFW content.
struct AgeVerificationView: View {
    @Binding var isPresented: Bool
    var onVerified: (Date) -> Void

    @State private var birthDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                DatePicker("Date of Birth", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .environment(\.locale, Locale(identifier: "en_US_POSIX"))
                Button("Verify") {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let dobString = formatter.string(from: birthDate)
                    let verifier = AgeVerifier()
                    if verifier.isAdult(dob: dobString) {
                        onVerified(birthDate)
                        isPresented = false
                    } else {
                        showAlert = true
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Verify Age")
            .alert("You must be 18+ to enable NSFW content.", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    AgeVerificationView(isPresented: .constant(true)) { _ in }
}
#endif
