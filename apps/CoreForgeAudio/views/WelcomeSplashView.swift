#if canImport(SwiftUI)
import SwiftUI
import CreatorCoreForge

/// Animated splash screen with logo and brand colors.
struct WelcomeSplashView: View {
    var onFinish: () -> Void
    @State private var show = false

    var body: some View {
        VStack {
            if show {
                Image(systemName: "headphones")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .transition(.scale)
                Text("CoreForge Audio")
                    .font(.title)
                    .foregroundColor(AppTheme.foregroundColor)
                    .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.primaryGradient.ignoresSafeArea())
        .onAppear {
            withAnimation(.easeInOut(duration: 0.6)) { show = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                onFinish()
            }
        }
    }
}

#Preview {
    WelcomeSplashView(onFinish: {})
}
#endif
