#if canImport(SwiftUI)
import SwiftUI

struct VisualOnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var animate = false

    var body: some View {
        TabView {
            page(image: "video", text: "Turn books into cinematic scenes")
            page(image: "paintpalette", text: "Choose styles, voices and FX")
            finalPage()
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear { withAnimation(.easeIn(duration: 0.6)) { animate = true } }
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
            Button("Start Creating") { hasSeenOnboarding = true }
                .buttonStyle(.borderedProminent)
                .opacity(animate ? 1 : 0)
        }
        .padding()
    }
}

private struct OnboardingPreview: View {
    @State private var seen = false
    var body: some View { VisualOnboardingView(hasSeenOnboarding: $seen) }
}

#Preview { OnboardingPreview() }
#endif
