import Foundation

/// Manages collections of books within named series for export and memory linking.
public final class SeriesManager {
    public static let shared = SeriesManager()
    private var series: [String: [String]] = [:]
    private let queue = DispatchQueue(label: "SeriesManager")

    private init() {}

    /// Add a book title to a series. If the series does not exist it will be created.
    public func addBook(_ title: String, toSeries name: String) {
        queue.sync {
            var books = series[name] ?? []
            if !books.contains(title) {
                books.append(title)
                series[name] = books
            }
        }
    }

    /// Retrieve all book titles in the given series.
    public func books(inSeries name: String) -> [String] {
        queue.sync { series[name] ?? [] }
    }

    /// Remove a book title from a series.
    public func removeBook(_ title: String, fromSeries name: String) {
        queue.sync {
            guard var books = series[name] else { return }
            books.removeAll { $0 == title }
            series[name] = books
        }
    }

    /// List all series names.
    public var allSeries: [String] {
        queue.sync { Array(series.keys) }
    }
}
