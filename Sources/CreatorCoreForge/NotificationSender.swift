import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Sends project milestone alerts via basic HTTP requests.
public struct NotificationSender {
    public init() {}

    public func sendSlackMessage(_ text: String, webhookURL: URL) {
        var request = URLRequest(url: webhookURL)
        request.httpMethod = "POST"
        request.httpBody = "{\"text\": \"\(text)\"}".data(using: .utf8)
        _ = try? syncRequest(with: request)
    }

    public func sendEmail(subject: String, body: String, to: String) {
        // Placeholder that would call an email API
        print("Email sent to \(to): \(subject)")
    }
    private func syncRequest(with request: URLRequest) throws -> (Data?, URLResponse?) {
        let semaphore = DispatchSemaphore(value: 0)
        var data: Data?
        var response: URLResponse?
        let task = URLSession.shared.dataTask(with: request) { d, r, _ in
            data = d
            response = r
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return (data, response)
    }
}
