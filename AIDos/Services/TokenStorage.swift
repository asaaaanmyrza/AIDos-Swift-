import Foundation

final class TokenStorage {
    static let shared = TokenStorage()
    
    private init() {}
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: "jwt_token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "jwt_token")
        }
    }
}
