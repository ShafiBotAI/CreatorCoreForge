#if canImport(SwiftUI) && canImport(VisionKit)
import SwiftUI
import VisionKit

/// Presents the system document scanner and returns combined OCR text.
struct DocumentScannerView: UIViewControllerRepresentable {
    var onText: (String) -> Void
    @Environment(\.presentationMode) private var presentation

    func makeCoordinator() -> Coordinator {
        Coordinator(onText: onText, dismiss: { presentation.wrappedValue.dismiss() })
    }

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let vc = VNDocumentCameraViewController()
        vc.delegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ controller: VNDocumentCameraViewController, context: Context) {}

    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        let onText: (String) -> Void
        let dismiss: () -> Void

        init(onText: @escaping (String) -> Void, dismiss: @escaping () -> Void) {
            self.onText = onText
            self.dismiss = dismiss
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let ocr = OCRScanMode()
            var text = ""
            for i in 0..<scan.pageCount {
                let img = scan.imageOfPage(at: i)
                if let data = img.jpegData(compressionQuality: 0.8) {
                    text += ocr.extractText(from: data) + "\n"
                }
            }
            onText(text)
            dismiss()
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            dismiss()
        }
    }
}
#endif
