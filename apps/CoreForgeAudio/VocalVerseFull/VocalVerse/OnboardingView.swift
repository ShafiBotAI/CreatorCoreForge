#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    var namespace: Namespace.ID
    @EnvironmentObject var onboarding: OnboardingManager
    @State private var animate = false

    var body: some View {
        TabView {
            page(image: "book.fill", text: "Forge audiobooks with AI")
            page(image: "waveform", text: "Voice casting, NSFW toggle, immersive sound FX")
            finalPage()
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            withAnimation(.easeIn(duration: 0.6)) { animate = true }
        }
    }

    private func page(image: String, text: String) -> some View {
        VStack(spacing: 20) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .opacity(animate ? 1 : 0)
            Text(text)
                .font(.title)
                .multilineTextAlignment(.center)
                .opacity(animate ? 1 : 0)
        }
        .padding()
    }

    private func finalPage() -> some View {
        VStack(spacing: 20) {
            Image(systemName: "arrow.forward.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .opacity(animate ? 1 : 0)
            Button("Enter App") {
                hasSeenOnboarding = true
                onboarding.complete(.finished)
            }
            .matchedGeometryEffect(id: "start", in: namespace)
            .buttonStyle(.borderedProminent)
            .opacity(animate ? 1 : 0)
        }
        .padding()
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    @State static var seen = false
    @Namespace static var ns
    static var previews: some View {
        OnboardingView(hasSeenOnboarding: $seen, namespace: ns)
            .environmentObject(OnboardingManager())
    }
}
#endif
#endif
