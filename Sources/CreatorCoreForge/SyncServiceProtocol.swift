import Foundation

public protocol SyncService {
    func upload(_ settings: [String: Any], userID: String, completion: @escaping (Bool) -> Void)
    func fetch(userID: String, completion: @escaping ([String: Any]?) -> Void)
}

extension SettingsSync: SyncService {}
