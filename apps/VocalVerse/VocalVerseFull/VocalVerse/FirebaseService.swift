import Foundation
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif
#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif
#if canImport(FirebaseStorage)
import FirebaseStorage
#endif

final class FirebaseService {
    static let shared = FirebaseService()

    #if canImport(FirebaseAuth)
    let auth = Auth.auth()
    #endif
    #if canImport(FirebaseFirestore)
    let db = Firestore.firestore()
    #endif
    #if canImport(FirebaseStorage)
    let storage = Storage.storage()
    #endif

    private init() {}
}
