import Foundation
import CreatorCoreForge

public func integrate_shared_autoupdater(version: String = "1.0",
                                         url: URL = URL(string: "https://example.com/latest.json")!,
                                         completion: @escaping (String?) -> Void) {
    let updater = AutoUpdater(updateURL: url)
    updater.checkForUpdate(currentVersion: version) { newVersion in
        completion(newVersion)
    }
}
