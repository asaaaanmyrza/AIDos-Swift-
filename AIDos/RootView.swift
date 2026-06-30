import SwiftUI
import Foundation

struct RootView: View {
    @ObservedObject private var tokenStorage = TokenStorage.shared
    
    var body: some View {
        if tokenStorage.token == nil {
            AuthView()
                .environmentObject(AuthViewModel())
        } else {
            MainView()
        }
    }
}

#Preview {
//    @ObservedObject var testToken = TokenStorage(token: nil)
    RootView()
}
