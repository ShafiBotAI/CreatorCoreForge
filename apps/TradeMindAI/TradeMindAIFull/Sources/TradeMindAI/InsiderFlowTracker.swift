import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Tracks insider trading filings and relevant news headlines.
public final class InsiderFlowTracker {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    /// Fetch recent SEC filings for a ticker symbol.
    public func fetchSECFilings(ticker: String, completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://data.sec.gov/submissions/CIK000000\(ticker).json") else {
            completion([])
            return
        }
        session.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let filings = obj["filings"] as? [String: Any],
                  let recent = filings["recent"] as? [String: Any],
                  let forms = recent["form"] as? [String] else {
                completion([])
                return
            }
            completion(forms)
        }.resume()
    }
}

