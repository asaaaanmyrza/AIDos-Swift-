import Foundation
import Combine

final class MainViewModel: ObservableObject {
    let auth: AuthViewModel
    
    let username: String
    
    init() {
        self.auth = AuthViewModel()
        auth.email.isEmpty ? (self.username = "") : (self.username = String(auth.email.split(separator: "@").first!))
    }
}
