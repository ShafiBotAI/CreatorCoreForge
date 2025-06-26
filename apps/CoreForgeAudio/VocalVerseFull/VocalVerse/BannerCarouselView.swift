#if canImport(SwiftUI)
import SwiftUI

/// Simple banner carousel for featured content.
struct BannerCarouselView: View {
    var body: some View {
        TabView {
            ForEach(0..<3) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.25))
                    Text("Featured \(index + 1)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(color: .white, radius: 4)
                }
                .padding(.horizontal)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}
#endif
