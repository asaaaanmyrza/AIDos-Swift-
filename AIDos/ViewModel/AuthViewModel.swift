import Foundation
import Combine
import SwiftUI

final class AuthViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var isLoading = false
    
    let networkService = NetworkService.shared
    
    func register() async {
        isLoading = true
        do {
            let auth = try await networkService.register(
                email: email,
                password: password)
            print("Successful register: \(auth.user.email)")
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func login() async {
        isLoading = true
        do {
            let auth = try await networkService.login(
                email: email,
                password: password
                )
            print("Successful login: \(auth.user.email)")
        } catch {
            print(error.localizedDescription)
            print("email: \(email), password: \(password)")
        }
        isLoading = false
    }
    
    func logout() {
        TokenStorage.shared.token = nil
    }
}
