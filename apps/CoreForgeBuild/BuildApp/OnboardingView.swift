#if canImport(SwiftUI)
import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var animate = false

    var body: some View {
        TabView {
            page(image: "hammer.fill", text: "Generate apps with AI")
            page(image: "paintpalette.fill", text: "Customize UI with Figma templates")
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
            Button("Enter App") { hasSeenOnboarding = true }
                .buttonStyle(.borderedProminent)
                .opacity(animate ? 1 : 0)
        }
        .padding()
    }
}
#endif
