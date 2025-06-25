#if canImport(SwiftUI) && canImport(WebKit)
import SwiftUI
import WebKit

/// SwiftUI view that renders a preview URL in a simple device frame.
public struct LivePreviewPane: View {
    public enum Device {
        case iOS, android, web
    }

    public var url: URL
    public var device: Device = .web

    public init(url: URL, device: Device = .web) {
        self.url = url
        self.device = device
    }

    public var body: some View {
        WebView(url: url)
            .frame(width: frameSize.width, height: frameSize.height)
            .border(Color.gray)
    }

    private var frameSize: CGSize {
        switch device {
        case .iOS: return CGSize(width: 375, height: 667)
        case .android: return CGSize(width: 360, height: 640)
        case .web: return CGSize(width: 800, height: 600)
        }
    }
}

private struct WebView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
#endif
